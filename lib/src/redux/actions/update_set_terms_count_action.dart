import 'package:vockify/src/redux/actions/app_action.dart';

class UpdateSetTermsCountAction extends AppAction {
  final int setId;
  final int termsCount;

  UpdateSetTermsCountAction(this.setId, this.termsCount);
}
