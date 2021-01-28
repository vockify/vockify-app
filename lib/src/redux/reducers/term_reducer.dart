import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/terms/add_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/remove_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/set_last_added_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/set_quiz_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/set_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/set_terms_loader_action.dart';
import 'package:vockify/src/redux/actions/terms/unset_quiz_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/unset_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/update_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';

class TermReducer {
  Reducer<AppState> _reducer;

  TermReducer() {
    _reducer = combineReducers([
      TypedReducer(_setUserTermsReducer),
      TypedReducer(_unsetTermsReducer),
      TypedReducer(_setQuizTermsReducer),
      TypedReducer(_unsetQuizTermsReducer),
      TypedReducer(_addUserTermReducer),
      TypedReducer(_updateTermReducer),
      TypedReducer(_removeUserTermReducer),
      TypedReducer(_setTermsLoaderReducer),
      TypedReducer(_setLastAddedTermsReducer),
    ]);
  }

  AppState getState(AppState state, Object action) => _reducer(state, action);

  AppState _addUserTermReducer(AppState state, AddUserTermAction action) {
    return state.rebuild((builder) {
      builder.terms.items.addEntries([MapEntry(action.term.id, action.term)]);
      builder.terms.ids.insert(0, action.term.id);
      builder.lastTerms.ids.insert(0, action.term.id);
    });
  }

  AppState _removeUserTermReducer(AppState state, RemoveUserTermAction action) {
    return state.rebuild((builder) {
      builder.terms.items.remove(action.id);
      builder.terms.ids.remove(action.id);
    });
  }

  AppState _setLastAddedTermsReducer(AppState state, SetLastAddedTermsAction action) {
    final entries = action.terms.map((term) => MapEntry(term.id, term));

    return state.rebuild((builder) {
      builder.terms.items.addEntries(entries);
      builder.lastTerms.ids.replace(action.terms.map((term) => term.id));
      builder.lastTerms.loader = LoaderState.isLoaded;
    });
  }

  AppState _setQuizTermsReducer(AppState state, SetQuizTermsAction action) {
    final entries = action.terms.map((term) => MapEntry(term.id, term));

    return state.rebuild((builder) {
      builder.terms.items.addEntries(entries);
      builder.quiz.ids.replace(action.terms.map((term) => term.id));
      builder.quiz.loader = LoaderState.isLoaded;
    });
  }

  AppState _setTermsLoaderReducer(AppState state, SetTermsLoaderAction action) {
    return state.rebuild((builder) {
      builder.terms.loader = action.state;
    });
  }

  AppState _setUserTermsReducer(AppState state, SetTermsAction action) {
    final entries = action.terms.map((term) => MapEntry(term.id, term));

    return state.rebuild((builder) {
      builder.terms.items.addEntries(entries);
      builder.terms.ids.replace(action.terms.map((term) => term.id));
      builder.terms.loader = LoaderState.isLoaded;
    });
  }

  AppState _unsetQuizTermsReducer(AppState state, UnsetQuizTermsAction action) {
    return state.rebuild((builder) {
      builder.quiz.ids.clear();
      builder.quiz.loader = LoaderState.isLoading;
    });
  }

  AppState _unsetTermsReducer(AppState state, UnsetTermsAction action) {
    return state.rebuild((builder) {
      builder.terms.ids.clear();
      builder.terms.loader = LoaderState.isLoading;
    });
  }

  AppState _updateTermReducer(AppState state, UpdateTermAction action) {
    return state.rebuild((builder) {
      builder.terms.items.addEntries([MapEntry(action.term.id, action.term)]);
    });
  }
}
