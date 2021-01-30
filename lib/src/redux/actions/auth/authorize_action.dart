import 'package:vockify/src/redux/actions/app_action.dart';

class AuthorizeAction extends AppAction {
  final String authToken;

  AuthorizeAction({this.authToken});
}
