import 'package:redux/redux.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/redux/actions/sets/add_user_set.dart';
import 'package:vockify/src/redux/actions/sets/remove_user_set_action.dart';
import 'package:vockify/src/redux/actions/sets/set_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/set_sets_loader_action.dart';
import 'package:vockify/src/redux/actions/sets/unset_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/update_set_action.dart';
import 'package:vockify/src/redux/actions/sets/update_set_terms_count_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

class SetReducer {
  late Reducer<AppState> _reducer;

  SetReducer() {
    _reducer = combineReducers([
      TypedReducer(_setSetsReducer),
      TypedReducer(_unsetSetsReducer),
      TypedReducer(_addUserSetReducer),
      TypedReducer(_updateSetReducer),
      TypedReducer(_removeUserSetReducer),
      TypedReducer(_updateSetTermsCountReducer),
      TypedReducer(_setSetsLoaderReducer),
    ]);
  }

  AppState getState(AppState state, Object action) => _reducer(state, action);

  AppState _addUserSetReducer(AppState state, AddUserSetAction action) {
    return state.rebuild((builder) {
      builder.sets.items.addEntries([MapEntry(action.set.id, action.set)]);
      builder.sets.userSetIds.insert(0, action.set.id);
    });
  }

  AppState _removeUserSetReducer(AppState state, RemoveUserSetAction action) {
    return state.rebuild((builder) {
      builder.sets.items.remove(action.id);
      builder.sets.userSetIds.remove(action.id);
    });
  }

  AppState _setSetsLoaderReducer(AppState state, SetSetsLoaderAction action) {
    return state.rebuild((builder) {
      builder.sets.loader = action.state;
    });
  }

  AppState _setSetsReducer(AppState state, SetSetsAction action) {
    final List<MapEntry<int, SetState>> entries = [];
    final List<int> userSetIds = [];
    final List<int> publicSetIds = [];

    action.sets.forEach((set) {
      entries.add(MapEntry(set.id, set));

      if (set.userId == AppApi.publicUserId) {
        publicSetIds.add(set.id);
      } else {
        userSetIds.add(set.id);
      }
    });

    return state.rebuild((builder) {
      builder.sets.items.addEntries(entries);
      builder.sets.userSetIds.replace(userSetIds);
      builder.sets.publicSetIds.replace(publicSetIds);
      builder.sets.loader = LoaderState.isLoaded;
    });
  }

  AppState _unsetSetsReducer(AppState state, UnsetSetsAction action) {
    return state.rebuild((builder) {
      builder.sets.userSetIds.clear();
      builder.sets.publicSetIds.clear();
      builder.sets.loader = LoaderState.isLoading;
    });
  }

  AppState _updateSetReducer(AppState state, UpdateSetAction action) {
    return state.rebuild((builder) {
      builder.sets.items.addEntries([MapEntry(action.set.id, action.set)]);
    });
  }

  AppState _updateSetTermsCountReducer(AppState state, UpdateSetTermsCountAction action) {
    return state.rebuild((builder) {
      builder.sets.items.updateValue(
        action.setId,
        (value) => value.rebuild((builder) {
          builder.terms.count = action.count;
        }),
      );
    });
  }
}
