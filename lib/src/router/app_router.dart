import 'package:flutter/material.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/pages/flashcards/flashcards_page.dart';
import 'package:vockify/src/pages/sets/sets_page.dart';
import 'package:vockify/src/pages/terms/public_terms_page.dart';
import 'package:vockify/src/pages/quiz/quiz_page.dart';
import 'package:vockify/src/pages/set/set_page.dart';
import 'package:vockify/src/pages/start/start_page.dart';
import 'package:vockify/src/pages/tour/tour_page.dart';
import 'package:vockify/src/pages/set_select/user_set_select_page.dart';
import 'package:vockify/src/pages/term/user_term_page.dart';
import 'package:vockify/src/pages/terms/user_terms_page.dart';
import 'package:vockify/src/services/amplitude.dart';
import 'package:vockify/src/widgets/home.dart';

typedef Widget PathBuilder(Map<String, dynamic> arguments);

class AppRouter {
  static final Map<String, PathBuilder> _paths = {
    Routes.tour: (arguments) => TourPageWidget(),
    Routes.start: (arguments) => StartPageWidget(),
    Routes.userSetSelect: (arguments) => UserSetSelectPageWidget(
          term: arguments['term'] as String,
          definition: arguments['definition'] as String,
        ),
    Routes.main: (arguments) => SetsPageWidget(),
    Routes.home: (arguments) => HomeWidget(),
    Routes.publicTerms: (arguments) => PublicTermsPageWidget(setId: arguments['id'] as int),
    Routes.userSet: (arguments) => SetPageWidget(setId: arguments['id'] as int?),
    Routes.quiz: (arguments) => QuizPageWidget(setId: arguments['setId'] as int),
    Routes.flashcards: (arguments) => FlashcardsPageWidget(setId: arguments['setId'] as int),
    Routes.userTerms: (arguments) => UserTermsPageWidget(setId: arguments['id'] as int),
    Routes.userTerm: (arguments) => UserTermPageWidget(
          setId: arguments['setId'] as int,
          termId: arguments['termId'] as int?,
        ),
  };

  static MaterialPageRoute<dynamic> buildRoute(RouteSettings settings, Widget builder) {
    amplitude.logEvent(
      'route_changed',
      eventProperties: {'name': settings.name, 'arguments': settings.arguments.toString()},
    );

    return MaterialPageRoute<dynamic>(
      settings: settings,
      builder: (context) => builder,
    );
  }

  static Route<dynamic> getRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    if (arguments != null && arguments is! Map<String, dynamic>) {
      throw ArgumentError("arguments cast error");
    }

    if (arguments == null) {

    }

    final pathBuilder = _paths[settings.name];

    if (pathBuilder != null) {
      return buildRoute(settings, pathBuilder(arguments as Map<String, dynamic>? ?? Map<String, dynamic>()));
    }

    throw Exception('Couldn\'t find path name');
  }
}
