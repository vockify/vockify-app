import 'package:flutter/material.dart';
import 'package:vockify/src/router/router.dart';

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
      onGenerateRoute: Router.getRoute,
      onGenerateInitialRoutes: (navigator, route) => [
        Router.getRoute(RouteSettings(name: settings.initialRoute)),
      ],
    );
  }
}
