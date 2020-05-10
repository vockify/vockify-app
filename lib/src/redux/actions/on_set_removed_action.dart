import 'package:vockify/src/api/dto/set_dto.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class OnSetRemoveAction extends AppAction {
  final int payload;

  OnSetRemoveAction(this.payload);
}