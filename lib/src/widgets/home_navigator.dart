import 'package:flutter/material.dart';

class HomeNavigatorSettings {
  final GlobalKey<NavigatorState> key;
  final Widget initialRoute;

  HomeNavigatorSettings(this.key, this.initialRoute);
}

class HomeNavigatorWidget extends StatelessWidget {
  final HomeNavigatorSettings settings;

  const HomeNavigatorWidget({Key? key, required this.settings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: settings.key,
      onGenerateRoute: (routeSettings) =>
          _buildRoute(routeSettings, settings.initialRoute),
      onGenerateInitialRoutes: (navigator, initialRoute) {
        return [
          _buildRoute(RouteSettings(name: '/'), settings.initialRoute),
        ];
      },
    );
  }

  Route<dynamic> _buildRoute(RouteSettings settings, Widget initialRoute) {
    final arguments = settings.arguments;

    if (arguments != null && arguments is! Map<String, dynamic>) {
      throw ArgumentError("arguments cast error");
    }

    return MaterialPageRoute<dynamic>(
      settings: settings,
      builder: (context) {
        return initialRoute;
      },
    );
  }
}
