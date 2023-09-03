import 'package:vockify/src/redux/actions/app_action.dart';

class UpdateSetTermsCountAction extends AppAction {
  final int setId;
  final int? count;

  UpdateSetTermsCountAction({required this.setId, this.count});
}
