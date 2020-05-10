import 'package:vockify/src/api/dto/set_dto.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class OnSetAddedAction extends AppAction {
  final SetDto payload;

  OnSetAddedAction(this.payload);
}