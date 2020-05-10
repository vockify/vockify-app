import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/authorize_action.dart';
import 'package:vockify/src/redux/actions/on_set_added_action.dart';
import 'package:vockify/src/redux/actions/on_set_removed_action.dart';
import 'package:vockify/src/redux/actions/on_sets_loaded_action.dart';
import 'package:vockify/src/redux/actions/unauthorize_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AppReducer {
  Reducer<AppState> _reducer;

  AppReducer() {
    _reducer = combineReducers([
      TypedReducer(_authorizeReducer),
      TypedReducer(_unauthorizeReducer),
      TypedReducer(_onSetsLoadedReducer),
      TypedReducer(_onSetAddedReducer),
      TypedReducer(_onSetRemovedReducer),
    ]);
  }

  AppState getState(AppState state, Object action) => _reducer(state, action);

  AppState _authorizeReducer(AppState state, AuthorizeAction action) {
    return state.rebuild((builder) => builder.isAuthorized = true);
  }

  AppState _unauthorizeReducer(AppState state, UnauthorizeAction action) {
    return state.rebuild((builder) => builder.isAuthorized = false);
  }

  AppState _onSetsLoadedReducer(AppState state, OnSetsLoadedAction action) {
    return state.rebuild((builder) => builder.sets = action.payload);
  }

  AppState _onSetAddedReducer(AppState state, OnSetAddedAction action) {
    return state
        .rebuild((builder) => builder.sets.data.insert(0, action.payload));
  }

  AppState _onSetRemovedReducer(AppState state, OnSetRemoveAction action) {
    return state.rebuild((builder) => builder.sets.data
        .removeWhere((element) => element.id == action.payload));
  }
}
