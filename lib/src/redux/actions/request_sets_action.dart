import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/router/routes.dart';

class RequestSetsAction extends AppAction {
  final String route;

  RequestSetsAction({this.route = Routes.sets});
}
