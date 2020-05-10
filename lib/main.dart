import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/sets_response.dart';
import 'package:vockify/src/redux/effects/app_effect.dart';
import 'package:vockify/src/redux/reducers/app_reducer.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/widgets/login.dart';
import 'package:vockify/src/widgets/sets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final isAuthorized = prefs.containsKey('token');

  final reducer = AppReducer();
  final effect = AppEffect();

  final epicMiddleware = new EpicMiddleware(effect.getEffects());

  final store = Store<AppState>(
    reducer.getState,
    middleware: [epicMiddleware],
    initialState: AppState((builder) {
      builder.isAuthorized = isAuthorized;
      builder.sets = new SetsResponse([]);
    }),
  );

  setupApi(store);

  runApp(VockifyApp(
    store: store,
  ));
}

class AuthLayout extends StatelessWidget {
  final Widget _widget;

  AuthLayout(this._widget);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      converter: (store) => store.state.isAuthorized,
      builder: (context, isAuthorized) {
        if (!isAuthorized) {
          scheduleMicrotask(() {
            Navigator.of(context).pushReplacementNamed('/');
          });

          return Container();
        }

        return _widget;
      },
    );
  }
}

class VockifyApp extends StatelessWidget {
  final Store<AppState> store;

  const VockifyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/sets': (context) => AuthLayout(SetsWidget()),
          '/': (context) => LoginWidget(),
        },
        title: 'Vockify',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
