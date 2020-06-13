import 'package:vockify/src/redux/actions/app_action.dart';

class RequestSetsAction extends AppAction {
  final bool shouldStartLoader;

  RequestSetsAction({this.shouldStartLoader = true});
}
