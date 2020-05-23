import 'package:vockify/src/router/route_path.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/auth_layout.dart';
import 'package:vockify/src/widgets/login.dart';
import 'package:vockify/src/widgets/profile.dart';
import 'package:vockify/src/widgets/quiz/quiz.dart';
import 'package:vockify/src/widgets/set.dart';
import 'package:vockify/src/widgets/sets.dart';
import 'package:vockify/src/widgets/share.dart';
import 'package:vockify/src/widgets/term.dart';
import 'package:vockify/src/widgets/terms.dart';

class RoutePaths {
  static final List<RoutePath> routePaths = [
    RoutePath(
      Routes.login,
      (arguments) => LoginWidget(),
    ),
    RoutePath(
      Routes.profile,
      (arguments) => ProfileWidget(),
    ),
    RoutePath(
      Routes.sets,
      (arguments) => AuthLayoutWidget(SetsWidget()),
    ),
    RoutePath(
      Routes.set,
      (arguments) => AuthLayoutWidget(SetWidget(int.tryParse(_getArgument(arguments, 'id')))),
    ),
    RoutePath(
      Routes.share,
      (arguments) => AuthLayoutWidget(ShareWidget(_getArgument(arguments, 'term'))),
    ),
    RoutePath(
      Routes.quiz,
      (arguments) => AuthLayoutWidget(QuizWidget()),
    ),
    RoutePath(
      Routes.terms,
      (arguments) => AuthLayoutWidget(TermsWidget(int.parse(_getArgument(arguments, 'id')))),
    ),
    RoutePath(
      Routes.term,
      (arguments) {
        final setId = int.parse(_getArgument(arguments, 'setId'));
        final termId = int.tryParse(_getArgument(arguments, 'termId'));

        return AuthLayoutWidget(TermWidget(setId, termId));
      },
    ),
  ];

  static String _getArgument(Map<String, String> arguments, String key) {
    if (!arguments.containsKey(key)) {
      throw ArgumentError("Route param:'$key' does not present");
    }

    return arguments[key];
  }
}
