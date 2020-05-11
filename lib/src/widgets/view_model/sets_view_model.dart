import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/request_remove_set_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state.dart';

class SetsViewModel {
  final Function(int) removeSet;
  final BuiltList<SetState> sets;

  SetsViewModel({this.removeSet, this.sets});

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetsViewModel && this.sets == other.sets;
  }

  static SetsViewModel fromStore(Store<AppState> store) {
    return SetsViewModel(
      sets: store.state.sets,
      removeSet: (id) => store.dispatch(RequestRemoveSetAction(id)),
    );
  }

  @override
  int get hashCode => sets.hashCode;
}