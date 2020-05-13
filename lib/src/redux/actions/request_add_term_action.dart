import 'package:vockify/src/api/dto/term_dto.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class RequestAddTermAction extends AppAction {
  final TermDto payload;

  RequestAddTermAction(this.payload);
}
