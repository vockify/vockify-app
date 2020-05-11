import 'package:vockify/src/redux/actions/app_action.dart';

class RequestSetTermsAction extends AppAction {
  final int payload;

  RequestSetTermsAction(this.payload);
}
