import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/page_transitions/page_transitions_theme.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/router.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_loader.dart';

class VockifyApp extends StatelessWidget {
  final Store<AppState> store;
  final String intent;

  VockifyApp({Key key, this.store, this.intent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        navigatorKey: NavigatorHolder.navigatorKey,
        onGenerateRoute: Router.getRoute,
        onGenerateInitialRoutes: _getInitialRoutes,
        title: 'Vockify',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: VockifyColors.primary),
          primaryColor: VockifyColors.primary,
          primarySwatch: VockifyColors.primary,
          visualDensity: VisualDensity.adaptivePlatformDensity,
//          pageTransitionsTheme: pageTransitionsTheme,
        ),
      ),
    );
  }

  List<Route> _getInitialRoutes(String route) {
    if (intent != null) {
      return [
        Router.buildRoute(
          RouteSettings(name: Routes.share),
          AppLoaderWidget(
            route: Routes.share,
            arguments: {'term': intent},
          ),
        ),
      ];
    }

    return [
      Router.buildRoute(
        RouteSettings(name: Routes.home),
        AppLoaderWidget(
          route: Routes.home,
        ),
      ),
    ];
  }
}
