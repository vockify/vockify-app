import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/sets/add_user_set.dart';
import 'package:vockify/src/redux/actions/sets/remove_user_set_action.dart';
import 'package:vockify/src/redux/actions/sets/set_added_user_set_action.dart';
import 'package:vockify/src/redux/actions/sets/set_public_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/set_user_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/set_user_sets_loader_action.dart';
import 'package:vockify/src/redux/actions/sets/unset_public_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/unset_user_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/update_user_set_action.dart';
import 'package:vockify/src/redux/actions/sets/update_user_set_terms_count_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';

class SetReducer {
  Reducer<AppState> _reducer;

  SetReducer() {
    _reducer = combineReducers([
      TypedReducer(_setUserSetsReducer),
      TypedReducer(_unsetUserSetsReducer),
      TypedReducer(_setPublicSetsReducer),
      TypedReducer(_unsetPublicSetsReducer),
      TypedReducer(_addUserSetReducer),
      TypedReducer(_updateUserSetReducer),
      TypedReducer(_removeUserSetReducer),
      TypedReducer(_updateUserSetTermsCountReducer),
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

  AppState _setPublicSetsReducer(AppState state, SetPublicSetsAction action) {
    final entries = action.sets.map((set) => MapEntry(set.id, set));

    return state.rebuild((builder) {
      builder.sets.public.items.replace(Map.fromEntries(entries));
      builder.sets.public.ids.replace(action.sets.map((set) => set.id));
      builder.sets.public.loader = LoaderState.isLoaded;
    });
  }

  AppState _setUserSetsLoader(AppState state, SetUserSetsLoaderAction action) {
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
      builder.sets.user.added = null;
    });
  }

  AppState _unsetPublicSetsReducer(AppState state, UnsetPublicSetsAction action) {
    return state.rebuild((builder) {
      builder.sets.public.items.clear();
      builder.sets.public.ids.clear();
      builder.sets.public.loader = LoaderState.isLoading;
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

  AppState _updateUserSetReducer(AppState state, UpdateUserSetAction action) {
    return state.rebuild((builder) {
      builder.sets.user.items.addEntries([MapEntry(action.set.id, action.set)]);
    });
  }

  AppState _updateUserSetTermsCountReducer(AppState state, UpdateUserSetTermsCountAction action) {
    return state.rebuild((builder) {
      builder.sets.user.items.updateValue(
        action.setId,
        (value) => value.rebuild((builder) {
          builder.termsCount = action.termsCount;
        }),
      );
    });
  }
}
