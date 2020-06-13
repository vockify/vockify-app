import 'package:vockify/src/router/route_path.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/auth_layout.dart';
import 'package:vockify/src/widgets/pages/login/login_page.dart';
import 'package:vockify/src/widgets/pages/profile/profile_page.dart';
import 'package:vockify/src/widgets/pages/quiz/quiz_page.dart';
import 'package:vockify/src/widgets/pages/set/set_page.dart';
import 'package:vockify/src/widgets/pages/sets/sets_page.dart';
import 'package:vockify/src/widgets/pages/share/share_page.dart';
import 'package:vockify/src/widgets/pages/term/term_page.dart';
import 'package:vockify/src/widgets/pages/terms/terms_page.dart';
import 'package:vockify/src/widgets/pages/tour/tour_page.dart';

class RoutePaths {
  static final List<RoutePath> routePaths = [
    RoutePath(
      Routes.login,
      (arguments) => LoginPageWidget(),
    ),
    RoutePath(
      Routes.profile,
      (arguments) => ProfilePageWidget(),
    ),
    RoutePath(
      Routes.tour,
          (arguments) => TourPageWidget(),
    ),
    RoutePath(
      Routes.sets,
      (arguments) => AuthLayoutWidget(SetsPageWidget()),
    ),
    RoutePath(
      Routes.set,
      (arguments) => AuthLayoutWidget(SetPageWidget(_getArgument(arguments, 'id') as int)),
    ),
    RoutePath(
      Routes.share,
      (arguments) => AuthLayoutWidget(SharePageWidget(_getArgument(arguments, 'term') as String)),
    ),
    RoutePath(
      Routes.quiz,
      (arguments) => AuthLayoutWidget(QuizPageWidget(setId: _getArgument(arguments, 'setId') as int)),
    ),
    RoutePath(
      Routes.terms,
      (arguments) => AuthLayoutWidget(TermsPageWidget(_getArgument(arguments, 'id') as int)),
    ),
    RoutePath(
      Routes.term,
      (arguments) {
        final setId = _getArgument(arguments, 'setId') as int;
        final termId = _getArgument(arguments, 'termId') as int;

        return AuthLayoutWidget(TermPageWidget(setId, termId));
      },
    ),
  ];

  static dynamic _getArgument(Map<String, dynamic> arguments, String key) {
    if (!arguments.containsKey(key)) {
      throw ArgumentError("Route param:'$key' does not present");
    }

    return arguments[key];
  }
}
