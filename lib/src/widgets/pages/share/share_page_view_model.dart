import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

class SharePageViewModel {
  final List<SetState> sets;
  final int selectedSetId;

  SharePageViewModel.fromStore(Store<AppState> store)
      : sets = getUserSets(store.state),
        selectedSetId = store.state.user.selectedSetId;

  @override
  int get hashCode => hash2(sets, selectedSetId);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SharePageViewModel && this.sets == other.sets && this.selectedSetId == other.selectedSetId;
  }
}
