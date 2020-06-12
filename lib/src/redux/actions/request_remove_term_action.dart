import 'package:vockify/src/redux/actions/app_action.dart';

class RequestRemoveTermAction extends AppAction {
  final int termId;
  final int setId;

  RequestRemoveTermAction({this.setId, this.termId});
}
