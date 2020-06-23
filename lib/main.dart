import 'package:flutter/material.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/redux/effects/app_effect.dart';
import 'package:vockify/src/redux/effects/set_effect.dart';
import 'package:vockify/src/redux/effects/term_effect.dart';
import 'package:vockify/src/redux/reducers/app_reducer.dart';
import 'package:vockify/src/redux/reducers/set_reducer.dart';
import 'package:vockify/src/redux/reducers/term_reducer.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/services/app_storage/app_storage.dart';
import 'package:vockify/src/services/app_storage/app_storage_key.dart';
import 'package:vockify/src/vockify_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = AppStorage.getInstance();
  final isAuthorized = await storage.containsKey(AppStorageKey.token);
  final selectedSetId = await storage.getValue(AppStorageKey.selectedSetId);

  final reducer = AppReducer(SetReducer(), TermReducer());
  final effect = AppEffect(SetEffect(), TermEffect());

  final store = Store<AppState>(
    reducer.getState,
    middleware: [
      EpicMiddleware(effect.getEffects()),
      NavigationMiddleware(),
    ],
    initialState: AppState.initial(
      isAuthorized: isAuthorized,
      selectedSetId: int.tryParse(selectedSetId ?? ''),
    ),
  );

  setupApi(store);
  setupDispatcher(store);

  final intent = await ReceiveSharingIntent.getInitialText();

  runApp(VockifyApp(
    store: store,
    intent: intent,
  ));
}
