import 'package:vockify/src/redux/actions/app_action.dart';

class RemoveUserTermAction extends AppAction {
  final int id;

  RemoveUserTermAction({required this.id});
}