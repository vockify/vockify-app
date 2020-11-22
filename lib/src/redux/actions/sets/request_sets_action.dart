import 'package:vockify/src/redux/actions/app_action.dart';

class RequestSetsAction extends AppAction {
  final List<int> userIds;

  RequestSetsAction({this.userIds});
}
