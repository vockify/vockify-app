import 'package:vockify/src/api/dto/set_dto.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class RequestAddSetAction extends AppAction {
  final SetDto payload;

  RequestAddSetAction(this.payload);
}
