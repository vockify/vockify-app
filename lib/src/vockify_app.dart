import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/page_transitions/page_transitions_theme.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/route_path.dart';
import 'package:vockify/src/router/router.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_loader.dart';

import 'router/route_paths.dart';

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

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => builder,
    );
  }

  List<Route> _getInitialRoutes(String route) {
    if (route == Routes.login || route == Routes.app) {
      return [_buildRoute(RouteSettings(name: Routes.app), AppLoaderWidget(route: Routes.sets))];
    }

    return [_buildRoute(RouteSettings(name: route), AppLoaderWidget(route: route))];
  }

  Route _getRoute(RouteSettings settings) {
    for (RoutePath routePath in RoutePaths.routePaths) {
      final router = Router(routePath, settings);

      if (router.matches()) {
        return _buildRoute(settings, routePath.builder(router.getArguments()));
      }
    }

    return _buildRoute(settings, AppLoaderWidget(route: Routes.sets));
  }
}
