import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

class SetsViewModel {
  final List<SetState> sets;
  final LoaderState loader;

  SetsViewModel.fromStore(Store<AppState> store)
      : sets = getUserSets(store.state),
        loader = store.state.sets.user.loader;

  @override
  int get hashCode => hash2(sets, loader);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetsViewModel && this.sets == other.sets && this.loader == other.loader;
  }
}
