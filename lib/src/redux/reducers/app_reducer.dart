import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/add_set_action.dart';
import 'package:vockify/src/redux/actions/authorize_action.dart';
import 'package:vockify/src/redux/actions/remove_set_action.dart';
import 'package:vockify/src/redux/actions/set_sets_action.dart';
import 'package:vockify/src/redux/actions/unauthorize_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AppReducer {
  Reducer<AppState> _reducer;

  AppReducer() {
    _reducer = combineReducers([
      TypedReducer(_authorizeReducer),
      TypedReducer(_unauthorizeReducer),
      TypedReducer(_setSetsReducer),
      TypedReducer(_addSetReducer),
      TypedReducer(_removeSetReducer),
    ]);
  }

  AppState getState(AppState state, Object action) => _reducer(state, action);

  AppState _authorizeReducer(AppState state, AuthorizeAction action) {
    return state.rebuild((builder) => builder.isAuthorized = true);
  }

  AppState _unauthorizeReducer(AppState state, UnauthorizeAction action) {
    return state.rebuild((builder) => builder.isAuthorized = false);
  }

  AppState _setSetsReducer(AppState state, SetSetsAction action) {
    return state.rebuild((builder) => builder.sets.replace(action.payload));
  }

  AppState _addSetReducer(AppState state, AddSetAction action) {
    return state
        .rebuild((builder) => builder.sets.insert(0, action.payload));
  }

  AppState _removeSetReducer(AppState state, RemoveSetAction action) {
    return state.rebuild((builder) => builder.sets
        .removeWhere((element) => element.id == action.payload));
  }
}
