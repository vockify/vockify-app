import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

class PublicSetItemModel {
  final SetState? set;
  final bool isAdded;

  PublicSetItemModel.fromStore(Store<AppState> store, int id)
      : set = getSetById(store.state, id),
        isAdded = getUserSetParentIds(store.state).contains(id);

  @override
  int get hashCode => hash2(set, isAdded);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PublicSetItemModel && this.set == other.set && this.isAdded == other.isAdded;
  }
}
