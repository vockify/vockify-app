import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/page_transitions/page_transitions_theme.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/route_path.dart';
import 'package:vockify/src/router/router.dart';
import 'package:vockify/src/widgets/app_loader.dart';
import 'package:vockify/src/vockify_colors.dart';

import 'router/routes.dart';

class VockifyApp extends StatelessWidget {
  final Store<AppState> store;

  VockifyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        navigatorKey: NavigatorHolder.navigatorKey,
        onGenerateRoute: _getRoute,
        onGenerateInitialRoutes: _getInitialRoutes,
        title: 'Vockify',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: VockifyColors.primary),
          primaryColor: VockifyColors.primary,
          primarySwatch: VockifyColors.primary,
          pageTransitionsTheme: pageTransitionsTheme,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }

  List<Route> _getInitialRoutes(String route) {
    if (route == '/login' || route == '/') {
      return [_buildRoute(RouteSettings(name: '/'), AppLoaderWidget())];
    }

    return [_getRoute(RouteSettings(name: route))];
  }

  Route _getRoute(RouteSettings settings) {
    for (RoutePath route in Routes.routes) {
      final router = Router(route, settings, store);

      if (router.matches()) {
        return _buildRoute(settings, route.builder(router));
      }
    }

    return _buildRoute(settings, AppLoaderWidget());
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
