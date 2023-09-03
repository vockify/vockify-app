import 'package:vockify/src/api/dto/terms/term_dto.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class RequestAddUserTermAction extends AppAction {
  final TermDto term;

  RequestAddUserTermAction({required this.term});
}
