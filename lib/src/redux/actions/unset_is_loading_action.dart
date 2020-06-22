import 'package:vockify/src/redux/actions/app_action.dart';

class UnsetIsLoadingAction extends AppAction {
  final String key;

  UnsetIsLoadingAction(this.key);
}
