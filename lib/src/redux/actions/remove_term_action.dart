import 'package:vockify/src/redux/actions/app_action.dart';

class RemoveTermAction extends AppAction {
  final int termId;
  final int setId;

  RemoveTermAction({this.setId, this.termId});
}