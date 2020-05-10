import 'package:redux/redux.dart';
import 'package:vockify/src/api/dto/set_dto.dart';
import 'package:vockify/src/redux/actions/remove_set_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class SetsViewModel {
  final Function(int) removeSet;
  final List<SetDto> sets;

  SetsViewModel({this.removeSet, this.sets});

  static SetsViewModel fromStore(Store<AppState> store) {
    return SetsViewModel(
        sets: store.state.sets.data,
        removeSet: (id) => store.dispatch(new RemoveSetAction(id)));
  }
}
