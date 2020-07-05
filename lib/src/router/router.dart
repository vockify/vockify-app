import 'package:flutter/material.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/home.dart';
import 'package:vockify/src/widgets/pages/login_page/login_page.dart';
import 'package:vockify/src/widgets/pages/main_page/main_page.dart';
import 'package:vockify/src/widgets/pages/profile_page/profile_page.dart';
import 'package:vockify/src/widgets/pages/public_terms_page/public_terms_page.dart';
import 'package:vockify/src/widgets/pages/quiz_page/quiz_page.dart';
import 'package:vockify/src/widgets/pages/search_page/search_page.dart';
import 'package:vockify/src/widgets/pages/set_page/set_page.dart';
import 'package:vockify/src/widgets/pages/share_page/share_page.dart';
import 'package:vockify/src/widgets/pages/tour_page/tour_page.dart';
import 'package:vockify/src/widgets/pages/user_term_page/user_term_page.dart';
import 'package:vockify/src/widgets/pages/user_terms_page/user_terms_page.dart';

typedef Widget PathBuilder(Map<String, dynamic> arguments);

class Router {
  static final Map<String, PathBuilder> _paths = {
    Routes.login: (arguments) => LoginPageWidget(),
    Routes.profile: (arguments) => ProfilePageWidget(),
    Routes.tour: (arguments) => TourPageWidget(),
    Routes.main: (arguments) => MainPageWidget(),
    Routes.home: (arguments) => HomeWidget(),
    Routes.search: (arguments) => SearchPageWidget(),
    Routes.publicTerms: (arguments) => PublicTermsPageWidget(setId: arguments['id'] as int),
    Routes.userSet: (arguments) => SetPageWidget(setId: arguments['id'] as int),
    Routes.share: (arguments) => SharePageWidget(term: arguments['term'] as String),
    Routes.quiz: (arguments) => QuizPageWidget(setId: arguments['setId'] as int),
    Routes.userTerms: (arguments) => UserTermsPageWidget(setId: arguments['id'] as int),
    Routes.userTerm: (arguments) =>
        UserTermPageWidget(setId: arguments['setId'] as int, termId: arguments['termId'] as int),
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
