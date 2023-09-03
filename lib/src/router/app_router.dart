import 'package:flutter/material.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/screens/flashcards_screen.dart';
import 'package:vockify/src/screens/login_screen.dart';
import 'package:vockify/src/screens/main_screen.dart';
import 'package:vockify/src/screens/profile_screen.dart';
import 'package:vockify/src/screens/public_terms_screen.dart';
import 'package:vockify/src/screens/quiz_screen.dart';
import 'package:vockify/src/screens/set_screen.dart';
import 'package:vockify/src/screens/start_screen.dart';
import 'package:vockify/src/screens/tour_screen.dart';
import 'package:vockify/src/screens/user_set_select_screen.dart';
import 'package:vockify/src/screens/user_term_screen.dart';
import 'package:vockify/src/screens/user_terms_screen.dart';
import 'package:vockify/src/services/amplitude.dart';
import 'package:vockify/src/widgets/home.dart';

typedef Widget PathBuilder(Map<String, dynamic> arguments);

class AppRouter {
  static final Map<String, PathBuilder> _paths = {
    Routes.login: (arguments) => LoginScreenWidget(),
    Routes.profile: (arguments) => ProfileScreenWidget(),
    Routes.tour: (arguments) => TourScreenWidget(),
    Routes.start: (arguments) => StartScreenWidget(),
    Routes.userSetSelect: (arguments) => UserSetSelectScreenWidget(
          term: arguments['term'] as String,
          definition: arguments['definition'] as String,
        ),
    Routes.main: (arguments) => MainScreenWidget(),
    Routes.home: (arguments) => HomeWidget(intent: arguments['intent'] as String),
    Routes.publicTerms: (arguments) => PublicTermsScreenWidget(setId: arguments['id'] as int),
    Routes.userSet: (arguments) => SetScreenWidget(setId: arguments['id'] as int),
    Routes.quiz: (arguments) => QuizScreenWidget(setId: arguments['setId'] as int),
    Routes.flashcards: (arguments) => FlashcardsScreenWidget(setId: arguments['setId'] as int),
    Routes.userTerms: (arguments) => UserTermsScreenWidget(setId: arguments['id'] as int),
    Routes.userTerm: (arguments) => UserTermScreenWidget(
          setId: arguments['setId'] as int,
          termId: arguments['termId'] as int,
        ),
  };

  static MaterialPageRoute buildRoute(RouteSettings settings, Widget builder) {
    amplitude.logEvent(
      'route_changed',
      eventProperties: {'name': settings.name, 'arguments': settings.arguments.toString()},
    );

    return MaterialPageRoute<dynamic>(
      settings: settings,
      builder: (context) => builder,
    );
  }

  static Route getRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    if (arguments != null && arguments is! Map<String, dynamic>) {
      throw ArgumentError("arguments cast error");
    }

    final pathBuilder = _paths[settings.name];

    if (pathBuilder != null) {
      return buildRoute(settings, pathBuilder(arguments as Map<String, dynamic>));
    }

    throw Exception('Couldn\'t find path name');
  }
}
