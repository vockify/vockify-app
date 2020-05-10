import 'package:built_collection/built_collection.dart';
import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/set_state.dart';

class SetSetsAction extends AppAction {
  final BuiltList<SetState> payload;
  
  SetSetsAction(this.payload);
}