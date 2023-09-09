import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/set_is_loading_action.dart';
import 'package:vockify/src/redux/actions/unset_is_loading_action.dart';
import 'package:vockify/src/redux/reducers/set_reducer.dart';
import 'package:vockify/src/redux/reducers/term_reducer.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AppReducer {
  late Reducer<AppState> _reducer;

  AppReducer(SetReducer setDataReducer, TermReducer termDataReducer) {
    _reducer = combineReducers([
      TypedReducer(setDataReducer.getState),
      TypedReducer(termDataReducer.getState),
      TypedReducer(_setIsLoadingReducer),
      TypedReducer(_unsetIsLoadingReducer),
    ]);
  }

  AppState getState(AppState state, dynamic action) => _reducer(state, action);

  AppState _setIsLoadingReducer(AppState state, SetIsLoadingAction action) {
    return state.rebuild((builder) => builder.isLoading = true);
  }

  AppState _unsetIsLoadingReducer(AppState state, UnsetIsLoadingAction action) {
    return state.rebuild((builder) => builder.isLoading = false);
  }
}
