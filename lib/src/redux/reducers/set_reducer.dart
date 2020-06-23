import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/add_user_set.dart';
import 'package:vockify/src/redux/actions/remove_user_set_action.dart';
import 'package:vockify/src/redux/actions/set_added_user_set_action.dart';
import 'package:vockify/src/redux/actions/set_user_sets_action.dart';
import 'package:vockify/src/redux/actions/set_user_sets_loader.dart';
import 'package:vockify/src/redux/actions/unset_user_sets_action.dart';
import 'package:vockify/src/redux/actions/update_set_terms_count_action.dart';
import 'package:vockify/src/redux/actions/update_user_set_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';

class SetReducer {
  Reducer<AppState> _reducer;

  SetReducer() {
    _reducer = combineReducers([
      TypedReducer(_setUserSetsReducer),
      TypedReducer(_unsetUserSetsReducer),
      TypedReducer(_addUserSetReducer),
      TypedReducer(_updateUserSetReducer),
      TypedReducer(_removeUserSetReducer),
      TypedReducer(_updateSetTermsCountReducer),
      TypedReducer(_setAddedUserSetReducer),
      TypedReducer(_setUserSetsLoader),
    ]);
  }

  AppState getState(AppState state, Object action) => _reducer(state, action);

  AppState _addUserSetReducer(AppState state, AddUserSetAction action) {
    return state.rebuild((builder) {
      builder.sets.user.items.addEntries([MapEntry(action.set.id, action.set)]);
      builder.sets.user.ids.insert(0, action.set.id);
    });
  }

  AppState _removeUserSetReducer(AppState state, RemoveUserSetAction action) {
    return state.rebuild((builder) {
      builder.sets.user.items.remove(action.id);
      builder.sets.user.ids.remove(action.id);
    });
  }

  AppState _setAddedUserSetReducer(AppState state, SetAddedUserSetAction action) {
    return state.rebuild((builder) {
      if (action.set == null) {
        builder.sets.user.added = null;
      } else {
        builder.sets.user.added.replace(action.set);
      }
    });
  }

  AppState _setUserSetsLoader(AppState state, SetUserSetsLoader action) {
    return state.rebuild((builder) {
      builder.sets.user.loader = action.state;
    });
  }

  AppState _setUserSetsReducer(AppState state, SetUserSetsAction action) {
    final entries = action.sets.map((set) => MapEntry(set.id, set));

    return state.rebuild((builder) {
      builder.sets.user.items.replace(Map.fromEntries(entries));
      builder.sets.user.ids.replace(action.sets.map((set) => set.id));
      builder.sets.user.loader = LoaderState.isLoaded;
    });
  }

  AppState _unsetUserSetsReducer(AppState state, UnsetUserSetsAction action) {
    return state.rebuild((builder) {
      builder.sets.user.items.clear();
      builder.sets.user.ids.clear();
      builder.sets.user.loader = LoaderState.isLoading;
      builder.sets.user.added = null;
    });
  }

  AppState _updateSetTermsCountReducer(AppState state, UpdateSetTermsCountAction action) {
    return state.rebuild((builder) {
      builder.sets.user.items.updateValue(
        action.setId,
        (value) => value.rebuild((builder) {
          builder.termsCount = action.termsCount;
        }),
      );
    });
  }

  AppState _updateUserSetReducer(AppState state, UpdateUserSetAction action) {
    return state.rebuild((builder) {
      builder.sets.user.items.addEntries([MapEntry(action.set.id, action.set)]);
    });
  }
}
