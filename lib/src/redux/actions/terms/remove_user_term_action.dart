import 'package:vockify/src/redux/actions/app_action.dart';

class RemoveUserTermAction extends AppAction {
  final int id;
  final int setId;

  RemoveUserTermAction(this.id, this.setId);
}