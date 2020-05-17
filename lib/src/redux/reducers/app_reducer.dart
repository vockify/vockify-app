import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/add_set_action.dart';
import 'package:vockify/src/redux/actions/add_term_action.dart';
import 'package:vockify/src/redux/actions/authorize_action.dart';
import 'package:vockify/src/redux/actions/remove_set_action.dart';
import 'package:vockify/src/redux/actions/remove_term_action.dart';
import 'package:vockify/src/redux/actions/set_is_loading_action.dart';
import 'package:vockify/src/redux/actions/set_sets_action.dart';
import 'package:vockify/src/redux/actions/set_terms_action.dart';
import 'package:vockify/src/redux/actions/set_user_action.dart';
import 'package:vockify/src/redux/actions/unauthorize_action.dart';
import 'package:vockify/src/redux/actions/unset_is_loading_action.dart';
import 'package:vockify/src/redux/actions/update_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AppReducer {
  Reducer<AppState> _reducer;

  AppReducer() {
    _reducer = combineReducers([
      // authorization
      TypedReducer(_authorizeReducer),
      TypedReducer(_unauthorizeReducer),

      // sets
      TypedReducer(_setSetsReducer),
      TypedReducer(_setUserReducer),
      TypedReducer(_addSetReducer),
      TypedReducer(_removeSetReducer),

      // terms
      TypedReducer(_setTermsReducer),
      TypedReducer(_addTermReducer),
      TypedReducer(_updateTermReducer),
      TypedReducer(_removeTermReducer),

      // loading actions
      TypedReducer(_setIsLoadingReducer),
      TypedReducer(_unsetIsLoadingReducer),
    ]);
  }

  AppState getState(AppState state, Object action) => _reducer(state, action);

  // authorization
  AppState _authorizeReducer(AppState state, AuthorizeAction action) {
    return state.rebuild((builder) => builder.isAuthorized = true);
  }

  AppState _unauthorizeReducer(AppState state, UnauthorizeAction action) {
    return state.rebuild((builder) => builder.isAuthorized = false);
  }

  // sets
  AppState _setSetsReducer(AppState state, SetSetsAction action) {
    return state.rebuild((builder) => builder.sets.replace(action.payload));
  }

  AppState _setUserReducer(AppState state, SetUserAction action) {
    return state.rebuild((builder) => builder.user.replace(action.payload));
  }

  AppState _addSetReducer(AppState state, AddSetAction action) {
    return state.rebuild((builder) => builder.sets.insert(0, action.payload));
  }

  AppState _removeSetReducer(AppState state, RemoveSetAction action) {
    return state.rebuild((builder) =>
        builder.sets.removeWhere((element) => element.id == action.payload));
  }

  // terms
  AppState _setTermsReducer(AppState state, SetTermsAction action) {
    return state.rebuild((builder) => builder.terms.replace(action.payload));
  }

  AppState _addTermReducer(AppState state, AddTermAction action) {
    return state.rebuild((builder) => builder.terms.insert(0, action.payload));
  }

  AppState _updateTermReducer(AppState state, UpdateTermAction action) {
    return state.rebuild((builder) => builder.terms.map((item) {
      if (item.id == action.payload.id) {
         item = action.payload;
      }

      return item;
    }));
  }

  AppState _removeTermReducer(AppState state, RemoveTermAction action) {
    return state.rebuild((builder) =>
        builder.terms.removeWhere((element) => element.id == action.payload));
  }

  // loading actions
  AppState _setIsLoadingReducer(AppState state, SetIsLoadingAction action) {
    return state.rebuild((builder) => builder.isLoading = true);
  }

  AppState _unsetIsLoadingReducer(AppState state, UnsetIsLoadingAction action) {
    return state.rebuild((builder) => builder.isLoading = false);
  }
}
