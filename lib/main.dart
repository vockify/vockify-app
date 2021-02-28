import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/extensions/sentry_client_extension.dart';
import 'package:vockify/src/redux/effects/app_effect.dart';
import 'package:vockify/src/redux/effects/auth_effect.dart';
import 'package:vockify/src/redux/effects/set_effect.dart';
import 'package:vockify/src/redux/effects/term_effect.dart';
import 'package:vockify/src/redux/middlewares/tracking_middleware.dart';
import 'package:vockify/src/redux/reducers/app_reducer.dart';
import 'package:vockify/src/redux/reducers/set_reducer.dart';
import 'package:vockify/src/redux/reducers/term_reducer.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/services/amplitude.dart';
import 'package:vockify/src/services/app_storage/app_storage.dart';
import 'package:vockify/src/services/app_storage/app_storage_key.dart';
import 'package:vockify/src/services/store_completer_service.dart';
import 'package:vockify/src/vockify_app.dart';

final SentryClient _sentry = new SentryClient(SentryOptions(
  dsn: "https://79567c6698cc4e25a42fd9a6cadf6c6b@o513596.ingest.sentry.io/5615842",
));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = AppStorage.getInstance();
  final authToken = await storage.getValue(AppStorageKey.token) ?? '';

  final reducer = AppReducer(SetReducer(), TermReducer());
  final effect = AppEffect(SetEffect(), TermEffect(), AuthEffect());

  final store = Store<AppState>(
    reducer.getState,
    middleware: [
      EpicMiddleware(effect.getEffects()),
      NavigationMiddleware(),
      TrackingMiddleware(),
    ],
    initialState: AppState.initial(authToken: authToken),
  );

  setupApi(store);
  setupDispatcher(store);
  setupStoreCompleterService(store);
  setupAmplitude();

  final intent = await ReceiveSharingIntent.getInitialText();

  FlutterError.onError = _sentry.exceptionHandler;

  runZonedGuarded<Future<void>>(() async {
    runApp(VockifyApp(
      store: store,
      intent: intent,
    ));
  }, (Object error, StackTrace stackTrace) {
    _sentry.reportError(error, stackTrace);
  });
}
