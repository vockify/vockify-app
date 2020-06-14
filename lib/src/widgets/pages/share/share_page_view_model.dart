import 'package:built_collection/built_collection.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state.dart';

class SharePageViewModel {
  final BuiltList<SetState> sets;
  final String translatedDefinition;

  SharePageViewModel.fromStore(Store<AppState> store)
      : sets = store.state.sets,
        translatedDefinition = store.state.translatedDefinition;

  @override
  int get hashCode => hash2(sets, translatedDefinition);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SharePageViewModel &&
        this.sets == other.sets &&
        this.translatedDefinition == other.translatedDefinition;
  }
}
