import 'package:vockify/src/redux/actions/app_action.dart';

class RequestSetTermsAction extends AppAction {
  final int setId;
  final bool shouldStartLoader;

  RequestSetTermsAction({this.setId, this.shouldStartLoader = true});
}
