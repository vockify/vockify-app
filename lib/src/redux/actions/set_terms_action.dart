import 'package:built_collection/built_collection.dart';
import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/term_state.dart';

class SetTermsAction extends AppAction {
  final BuiltList<TermState> payload;

  SetTermsAction(this.payload);
}