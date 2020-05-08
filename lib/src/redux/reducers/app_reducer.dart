import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/authorize_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AppReducer {
  Reducer<AppState> _reducer;

  AppReducer() {
    _reducer = combineReducers([
      TypedReducer(_authorizeReducer),
    ]);
  }

  AppState getState(AppState state, Object action) => _reducer(state, action);

  AppState _authorizeReducer(AppState state, AuthorizeAction action) {
    return state.rebuild((builder) => builder.isAuthorized = true);
  }
}
