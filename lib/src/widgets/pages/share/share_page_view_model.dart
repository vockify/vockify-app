import 'package:built_collection/built_collection.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state.dart';

class SharePageViewModel {
  final BuiltList<SetState> sets;
  final int selectedSetId;

  SharePageViewModel.fromStore(Store<AppState> store)
      : sets = store.state.sets,
        selectedSetId = store.state.selectedSetId;

  @override
  int get hashCode => hash2(sets, selectedSetId);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SharePageViewModel && this.sets == other.sets && this.selectedSetId == other.selectedSetId;
  }
}
