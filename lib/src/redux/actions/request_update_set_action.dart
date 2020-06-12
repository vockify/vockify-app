import 'package:vockify/src/api/dto/set_dto.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class RequestUpdateSetAction extends AppAction {
  final SetDto payload;

  RequestUpdateSetAction(this.payload);
}
