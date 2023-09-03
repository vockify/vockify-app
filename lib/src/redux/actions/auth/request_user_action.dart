import 'package:vockify/src/redux/actions/app_action.dart';

class RequestUserAction extends AppAction {
  final String route;
  final Map<String, dynamic> arguments;

  RequestUserAction({
    required this.route,
    required this.arguments,
  });
}
