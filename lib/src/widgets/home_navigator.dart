import 'package:flutter/material.dart';
import 'package:vockify/src/router/app_router.dart';

class HomeNavigatorSettings {
  final GlobalKey<NavigatorState> key;
  final String initialRoute;

  HomeNavigatorSettings(this.key, this.initialRoute);
}

class HomeNavigatorWidget extends StatelessWidget {
  final HomeNavigatorSettings settings;

  const HomeNavigatorWidget({Key key, @required this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: settings.key,
      onGenerateRoute: AppRouter.getRoute,
      onGenerateInitialRoutes: (navigator, route) => [
        AppRouter.getRoute(RouteSettings(name: settings.initialRoute)),
      ],
    );
  }
}
