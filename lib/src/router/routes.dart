import 'package:vockify/src/router/route_list.dart';
import 'package:vockify/src/router/route_path.dart';
import 'package:vockify/src/widgets/auth_layout.dart';
import 'package:vockify/src/widgets/login.dart';
import 'package:vockify/src/widgets/quiz/quiz.dart';
import 'package:vockify/src/widgets/sets.dart';
import 'package:vockify/src/widgets/term.dart';
import 'package:vockify/src/widgets/terms.dart';

class Routes {
  static final List<RoutePath> routePaths = [
    RoutePath(
      RouteList.login,
      (router) => LoginWidget(),
    ),
    RoutePath(
      RouteList.sets,
      (router) => AuthLayoutWidget(SetsWidget()),
    ),
    RoutePath(
      RouteList.quiz,
      (router) => AuthLayoutWidget(QuizWidget()),
    ),
    RoutePath(
      RouteList.terms,
      (router) => AuthLayoutWidget(TermsWidget(int.parse(router.getQueryArgument("id")))),
    ),
    RoutePath(
      RouteList.term,
      (router) {
        final setId = int.parse(router.getQueryArgument("setId"));
        final termId = int.tryParse(router.getQueryArgument("termId"));

        return AuthLayoutWidget(TermWidget(setId, termId));
      },
    ),
  ];
}
