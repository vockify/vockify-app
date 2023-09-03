import 'dart:async';

import 'package:redux_epics/redux_epics.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/terms/term_filters_dto.dart';
import 'package:vockify/src/redux/actions/set_is_loading_action.dart';
import 'package:vockify/src/redux/actions/sets/update_set_terms_count_action.dart';
import 'package:vockify/src/redux/actions/terms/add_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/remove_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/request_add_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/request_last_added_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/request_quiz_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/request_remove_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/request_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/request_update_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/set_last_added_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/set_quiz_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/set_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/update_term_action.dart';
import 'package:vockify/src/redux/actions/unset_is_loading_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class TermEffect {
  Epic<AppState> getEffects() {
    return combineEpics([
      TypedEpic<AppState, RequestTermsAction>(_requestUserTermsAction),
      TypedEpic<AppState, RequestQuizTermsAction>(_requestQuizTermsAction),
      TypedEpic<AppState, RequestAddUserTermAction>(_requestAddUserTermAction),
      TypedEpic<AppState, RequestUpdateUserTermAction>(_requestUpdateUserTermAction),
      TypedEpic<AppState, RequestRemoveUserTermAction>(_requestRemoveUserTermAction),
      TypedEpic<AppState, RequestLastAddedTermsAction>(_requestLastAddedTermsAction),
    ]);
  }

  Stream<Object> _requestAddUserTermAction(
    Stream<RequestAddUserTermAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield SetIsLoadingAction();

      final count = store.state.sets.items[action.term.setId]?.terms.count ?? 0;
      yield UpdateSetTermsCountAction(setId: action.term.setId, count: count + 1);

      try {
        final result = await api.addTerm(action.term);

        yield AddUserTermAction(term: TermState.fromDto(result.data));
      } finally {
        yield UnsetIsLoadingAction();
      }
    });
  }

  Stream<Object> _requestQuizTermsAction(
    Stream<RequestQuizTermsAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      final result = await api.getTerms(TermFiltersDto(setIds: [action.setId]));
      yield SetQuizTermsAction(terms: result.data.map((dto) => TermState.fromDto(dto)));
    });
  }

  Stream<Object> _requestRemoveUserTermAction(
    Stream<RequestRemoveUserTermAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield RemoveUserTermAction(id: action.id);

      final count = store.state.sets.items[action.setId]?.terms.count ?? 0;
      yield UpdateSetTermsCountAction(setId: action.setId, count: count - 1);

      if (action.id > 0) {
        await api.deleteTerm(action.id);
      }
    });
  }

  Stream<Object> _requestUpdateUserTermAction(
    Stream<RequestUpdateUserTermAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield SetIsLoadingAction();

      try {
        final result = await api.updateTerm(action.term.id, action.term);
        yield UpdateTermAction(term: TermState.fromDto(result.data));
      } finally {
        yield UnsetIsLoadingAction();
      }
    });
  }

  Stream<Object> _requestUserTermsAction(
    Stream<RequestTermsAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      final result = await api.getTerms(TermFiltersDto(setIds: [action.setId]));
      yield SetTermsAction(terms: result.data.map((dto) => TermState.fromDto(dto)));
    });
  }

  Stream<Object> _requestLastAddedTermsAction(
    Stream<RequestLastAddedTermsAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      final result = await api.getTerms(TermFiltersDto(perPage: 10, userIds: [getUserId(store.state)]));
      yield SetLastAddedTermsAction(terms: result.data.map((dto) => TermState.fromDto(dto)));
    });
  }
}
