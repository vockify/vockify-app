import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/terms/add_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/remove_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/set_added_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/set_public_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/set_public_terms_loader_action.dart';
import 'package:vockify/src/redux/actions/terms/set_quiz_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/set_user_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/set_user_terms_loader_action.dart';
import 'package:vockify/src/redux/actions/terms/unset_public_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/unset_quiz_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/unset_user_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/update_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';

class TermReducer {
  Reducer<AppState> _reducer;

  TermReducer() {
    _reducer = combineReducers([
      TypedReducer(_setUserTermsReducer),
      TypedReducer(_unsetUserTermsReducer),
      TypedReducer(_setPublicTermsReducer),
      TypedReducer(_unsetPublicTermsReducer),
      TypedReducer(_setQuizTermsReducer),
      TypedReducer(_unsetQuizTermsReducer),
      TypedReducer(_addUserTermReducer),
      TypedReducer(_updateTermReducer),
      TypedReducer(_removeUserTermReducer),
      TypedReducer(_setAddedUserTermReducer),
      TypedReducer(_setUserTermsLoader),
      TypedReducer(_setPublicTermsLoader),
    ]);
  }

  AppState getState(AppState state, Object action) => _reducer(state, action);

  AppState _addUserTermReducer(AppState state, AddUserTermAction action) {
    return state.rebuild((builder) {
      builder.terms.items.addEntries([MapEntry(action.term.id, action.term)]);
      builder.terms.user.ids.insert(0, action.term.id);
    });
  }

  AppState _removeUserTermReducer(AppState state, RemoveUserTermAction action) {
    return state.rebuild((builder) {
      builder.terms.items.remove(action.id);
      builder.terms.user.ids.remove(action.id);
    });
  }

  AppState _setAddedUserTermReducer(AppState state, SetAddedUserTermAction action) {
    return state.rebuild((builder) {
      if (action.term == null) {
        builder.terms.user.added = null;
      } else {
        builder.terms.user.added.replace(action.term);
      }
    });
  }

  AppState _setPublicTermsLoader(AppState state, SetPublicTermsLoaderAction action) {
    return state.rebuild((builder) {
      builder.terms.public.loader = action.state;
    });
  }

  AppState _setPublicTermsReducer(AppState state, SetPublicTermsAction action) {
    final entries = action.terms.map((term) => MapEntry(term.id, term));

    return state.rebuild((builder) {
      builder.terms.items.addEntries(entries);
      builder.terms.public.ids.replace(action.terms.map((term) => term.id));
      builder.terms.public.loader = LoaderState.isLoaded;
    });
  }

  AppState _setQuizTermsReducer(AppState state, SetQuizTermsAction action) {
    return state.rebuild((builder) {
      builder.quiz.items.replace(action.terms);
      builder.quiz.loader = LoaderState.isLoaded;
    });
  }

  AppState _setUserTermsLoader(AppState state, SetUserTermsLoaderAction action) {
    return state.rebuild((builder) {
      builder.terms.user.loader = action.state;
    });
  }

  AppState _setUserTermsReducer(AppState state, SetUserTermsAction action) {
    final entries = action.terms.map((term) => MapEntry(term.id, term));

    return state.rebuild((builder) {
      builder.terms.items.addEntries(entries);
      builder.terms.user.ids.replace(action.terms.map((term) => term.id));
      builder.terms.user.loader = LoaderState.isLoaded;
      builder.terms.user.added = null;
    });
  }

  AppState _unsetPublicTermsReducer(AppState state, UnsetPublicTermsAction action) {
    return state.rebuild((builder) {
      builder.terms.public.ids.clear();
      builder.terms.public.loader = LoaderState.isLoading;
    });
  }

  AppState _unsetQuizTermsReducer(AppState state, UnsetQuizTermsAction action) {
    return state.rebuild((builder) {
      builder.quiz.items.clear();
      builder.quiz.loader = LoaderState.isLoading;
    });
  }

  AppState _unsetUserTermsReducer(AppState state, UnsetUserTermsAction action) {
    return state.rebuild((builder) {
      builder.terms.user.ids.clear();
      builder.terms.user.loader = LoaderState.isLoading;
      builder.terms.user.added = null;
    });
  }

  AppState _updateTermReducer(AppState state, UpdateTermAction action) {
    return state.rebuild((builder) {
      builder.terms.items.addEntries([MapEntry(action.term.id, action.term)]);
    });
  }
}
