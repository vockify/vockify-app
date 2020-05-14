import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/page_transitions/page_transitions_theme.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/widgets/app_loader.dart';
import 'package:vockify/src/widgets/auth_layout.dart';
import 'package:vockify/src/widgets/login.dart';
import 'package:vockify/src/widgets/quiz/quiz.dart';
import 'package:vockify/src/widgets/sets.dart';
import 'package:vockify/src/widgets/term.dart';
import 'package:vockify/src/widgets/terms.dart';

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
          pageTransitionsTheme: pageTransitionsTheme,
          primarySwatch: Colors.orange,
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
    switch (settings.name) {
      case LoginWidget.route:
        return _buildRoute(settings, LoginWidget());
      case SetsWidget.route:
        return _buildRoute(settings, AuthLayoutWidget(SetsWidget()));
      case TermsWidget.route:
        return _buildRoute(settings, AuthLayoutWidget(TermsWidget(settings.arguments)));
      case QuizWidget.route:
        return _buildRoute(settings, AuthLayoutWidget(QuizWidget()));
      case TermWidget.route:
        return _buildRoute(settings, AuthLayoutWidget(TermWidget(settings.arguments)));
      default:
        return _buildRoute(settings, AppLoaderWidget());
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
