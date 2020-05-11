import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/widgets/app_loader.dart';
import 'package:vockify/src/widgets/auth_layout.dart';
import 'package:vockify/src/widgets/login.dart';
import 'package:vockify/src/widgets/quiz/quiz.dart';
import 'package:vockify/src/widgets/sets.dart';
import 'package:vockify/src/widgets/terms.dart';

class VockifyApp extends StatelessWidget {
  final Store<AppState> store;

  const VockifyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        navigatorKey: NavigatorHolder.navigatorKey,
        onGenerateRoute: _getRoute,
        title: 'Vockify',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
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
