import 'package:vockify/src/redux/actions/app_action.dart';

class RemoveTermAction extends AppAction {
  final int payload;

  RemoveTermAction(this.payload);
}