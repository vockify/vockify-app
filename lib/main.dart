import 'package:flutter/material.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/redux/effects/app_effect.dart';
import 'package:vockify/src/redux/reducers/app_reducer.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/vockify_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final isAuthorized = prefs.containsKey('token');

  final reducer = AppReducer();
  final effect = AppEffect();

  final epicMiddleware = new EpicMiddleware(effect.getEffects());

  final store = Store<AppState>(
    reducer.getState,
    middleware: [
      epicMiddleware,
      NavigationMiddleware(),
    ],
    initialState: AppState((builder) {
      builder
        ..isAuthorized = isAuthorized
        ..sets.replace([]);
    }),
  );

  setupApi(store);

  runApp(VockifyApp(
    store: store,
  ));
}
