import 'package:flutter/material.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/home.dart';
import 'package:vockify/src/widgets/pages/login/login_page.dart';
import 'package:vockify/src/widgets/pages/profile/profile_page.dart';
import 'package:vockify/src/widgets/pages/quiz/quiz_page.dart';
import 'package:vockify/src/widgets/pages/set/set_page.dart';
import 'package:vockify/src/widgets/pages/sets/sets_page.dart';
import 'package:vockify/src/widgets/pages/share/share_page.dart';
import 'package:vockify/src/widgets/pages/term/term_page.dart';
import 'package:vockify/src/widgets/pages/terms/terms_page.dart';
import 'package:vockify/src/widgets/pages/tour/tour_page.dart';

typedef Widget PathBuilder(Map<String, dynamic> arguments);

class Router {
  static final Map<String, PathBuilder> _paths = {
    Routes.login: (arguments) => LoginPageWidget(),
    Routes.profile: (arguments) => ProfilePageWidget(),
    Routes.tour: (arguments) => TourPageWidget(),
    Routes.sets: (arguments) => SetsPageWidget(),
    Routes.home: (arguments) => HomeWidget(),
    Routes.set: (arguments) => SetPageWidget(setId: arguments['id'] as int),
    Routes.share: (arguments) => SharePageWidget(term: arguments['term'] as String),
    Routes.quiz: (arguments) => QuizPageWidget(setId: arguments['setId'] as int),
    Routes.terms: (arguments) => TermsPageWidget(arguments['id'] as int),
    Routes.term: (arguments) => TermPageWidget(setId: arguments['setId'] as int, termId: arguments['termId'] as int),
  };

  static MaterialPageRoute buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => builder,
    );
  }

  static Route getRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    if (arguments != null && arguments is! Map<String, dynamic>) {
      throw ArgumentError("arguments cast error");
    }

    return buildRoute(settings, _paths[settings.name](arguments as Map<String, dynamic>));
  }
}
