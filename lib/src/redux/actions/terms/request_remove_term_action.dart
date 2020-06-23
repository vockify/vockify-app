import 'package:vockify/src/redux/actions/app_action.dart';

class RequestRemoveTermAction extends AppAction {
  final int id;

  RequestRemoveTermAction(this.id);
}
