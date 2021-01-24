import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/auth/authorize_action.dart';
import 'package:vockify/src/redux/actions/auth/set_user_action.dart';
import 'package:vockify/src/redux/actions/set_current_route_action.dart';
import 'package:vockify/src/redux/actions/set_is_loading_action.dart';
import 'package:vockify/src/redux/actions/unset_is_loading_action.dart';
import 'package:vockify/src/redux/reducers/set_reducer.dart';
import 'package:vockify/src/redux/reducers/term_reducer.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AppReducer {
  Reducer<AppState> _reducer;

  AppReducer(SetReducer setDataReducer, TermReducer termDataReducer) {
    _reducer = combineReducers([
      TypedReducer(setDataReducer.getState),
      TypedReducer(termDataReducer.getState),
      TypedReducer(_authorizeReducer),
      TypedReducer(_setUserReducer),
      TypedReducer(_setIsLoadingReducer),
      TypedReducer(_unsetIsLoadingReducer),
      TypedReducer(_setCurrentRouteReducer),
    ]);
  }

  AppState getState(AppState state, Object action) => _reducer(state, action);

  AppState _authorizeReducer(AppState state, AuthorizeAction action) {
    return state.rebuild((builder) => builder.isAuthorized = true);
  }

  AppState _setCurrentRouteReducer(AppState state, SetCurrentRouteAction action) {
    return state.rebuild((builder) => builder.currentRoute = action.route);
  }

  AppState _setIsLoadingReducer(AppState state, SetIsLoadingAction action) {
    return state.rebuild((builder) => builder.isLoading = true);
  }

  AppState _setUserReducer(AppState state, SetUserAction action) {
    return state.rebuild((builder) => builder.user.replace(action.user));
  }

  AppState _unsetIsLoadingReducer(AppState state, UnsetIsLoadingAction action) {
    return state.rebuild((builder) => builder.isLoading = false);
  }
}
