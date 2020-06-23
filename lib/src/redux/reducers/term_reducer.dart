import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/add_term_action.dart';
import 'package:vockify/src/redux/actions/remove_term_action.dart';
import 'package:vockify/src/redux/actions/set_added_term_action.dart';
import 'package:vockify/src/redux/actions/set_terms_action.dart';
import 'package:vockify/src/redux/actions/unset_terms_action.dart';
import 'package:vockify/src/redux/actions/update_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class TermReducer {
  Reducer<AppState> _reducer;

  TermReducer() {
    _reducer = combineReducers([
      TypedReducer(_setTermsReducer),
      TypedReducer(_unsetTermsReducer),
      TypedReducer(_addTermReducer),
      TypedReducer(_updateTermReducer),
      TypedReducer(_removeTermReducer),
      TypedReducer(_setAddedTermReducer),
    ]);
  }

  AppState getState(AppState state, Object action) => _reducer(state, action);

  AppState _addTermReducer(AppState state, AddTermAction action) {
    return state.rebuild((builder) {
      builder.terms.items.addEntries([MapEntry(action.term.id, action.term)]);
      builder.terms.ids.insert(0, action.term.id);
    });
  }

  AppState _removeTermReducer(AppState state, RemoveTermAction action) {
    return state.rebuild((builder) {
      builder.terms.items.remove(action.id);
      builder.terms.ids.remove(action.id);
    });
  }

  AppState _setAddedTermReducer(AppState state, SetAddedTermAction action) {
    return state.rebuild((builder) {
      if (action.term == null) {
        builder.terms.added = null;
      } else {
        builder.terms.added.replace(action.term);
      }
    });
  }

  AppState _setTermsReducer(AppState state, SetTermsAction action) {
    final entries = action.terms.map((term) => MapEntry(term.id, term));

    return state.rebuild((builder) {
      builder.terms.items.replace(Map.fromEntries(entries));
      builder.terms.ids.replace(action.terms.map((term) => term.id));
      builder.terms.isLoaded = true;
    });
  }

  AppState _unsetTermsReducer(AppState state, UnsetTermsAction action) {
    return state.rebuild((builder) {
      builder.terms.items.clear();
      builder.terms.ids.clear();
      builder.terms.isLoaded = false;
      builder.terms.added = null;
    });
  }

  AppState _updateTermReducer(AppState state, UpdateTermAction action) {
    return state.rebuild((builder) {
      builder.terms.items.addEntries([MapEntry(action.term.id, action.term)]);
    });
  }
}
