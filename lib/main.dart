import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:vockify/src/redux/effects/app_effect.dart';
import 'package:vockify/src/redux/reducers/app_reducer.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/widgets/login.dart';
import 'package:vockify/src/widgets/sets.dart';

void main() {
  final reducer = AppReducer();
  final effect = AppEffect();

  final epicMiddleware = new EpicMiddleware(effect.getEffects());

  final store = Store<AppState>(
    reducer.getState,
    middleware: [epicMiddleware],
    initialState: AppState((builder) {
      builder.isAuthorized = false;
    }),
  );

  runApp(VockifyApp(
    store: store,
  ));
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
          '/sets': (context) => SetsWidget(),
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
