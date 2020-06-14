import 'package:vockify/src/redux/actions/app_action.dart';

class RequestTranslateAction extends AppAction {
  final String term;

  RequestTranslateAction(this.term);
}
