import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

class SearchViewModel {
  final List<SetState> sets;
  final LoaderState loader;

  SearchViewModel.fromStore(Store<AppState> store)
      : sets = getPublicSets(store.state),
        loader = store.state.sets.public.loader;

  @override
  int get hashCode => hash2(sets, loader);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchViewModel && this.sets == other.sets && this.loader == other.loader;
  }
}
