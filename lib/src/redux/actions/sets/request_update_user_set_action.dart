import 'package:vockify/src/api/dto/sets/set_dto.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class RequestUpdateUserSetAction extends AppAction {
  final SetDto set;

  RequestUpdateUserSetAction({required this.set});
}
