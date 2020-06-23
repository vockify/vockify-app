import 'dart:async';

import 'package:redux_epics/redux_epics.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/term_dto.dart';
import 'package:vockify/src/redux/actions/add_term_action.dart';
import 'package:vockify/src/redux/actions/remove_term_action.dart';
import 'package:vockify/src/redux/actions/request_add_term_action.dart';
import 'package:vockify/src/redux/actions/request_remove_term_action.dart';
import 'package:vockify/src/redux/actions/request_terms_action.dart';
import 'package:vockify/src/redux/actions/request_update_term_action.dart';
import 'package:vockify/src/redux/actions/set_added_term_action.dart';
import 'package:vockify/src/redux/actions/set_terms_action.dart';
import 'package:vockify/src/redux/actions/update_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class TermEffect {
  Epic<AppState> getEffects() {
    return combineEpics([
      TypedEpic<AppState, RequestTermsAction>(_requestTermsAction),
      TypedEpic<AppState, RequestAddTermAction>(_requestAddTermAction),
      TypedEpic<AppState, RequestUpdateTermAction>(_requestUpdateTermAction),
      TypedEpic<AppState, RequestRemoveTermAction>(_requestRemoveTermAction),
    ]);
  }

  Stream<Object> _requestAddTermAction(
    Stream<RequestAddTermAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield SetAddedTermAction(action.term);

      try {
        final result = await api.addTerm(TermDto.fromState(action.term));

        if (store.state.terms.isLoaded) {
          yield AddTermAction(TermState.fromDto(result.data));
        }
      } catch (e) {
        print(e);
      } finally {
        yield SetAddedTermAction(null);
      }
    });
  }

  Stream<Object> _requestRemoveTermAction(
    Stream<RequestRemoveTermAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield RemoveTermAction(action.id);

      try {
        if (action.id > 0) {
          await api.deleteTerm(action.id);
        }
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<Object> _requestTermsAction(
    Stream<RequestTermsAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      try {
        final result = await api.getSetTerms(action.setId);
        yield SetAddedTermAction(null);
        yield SetTermsAction(result.data.map((dto) => TermState.fromDto(dto)));
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<Object> _requestUpdateTermAction(
    Stream<RequestUpdateTermAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield UpdateTermAction(action.term);

      try {
        final result = await api.updateTerm(action.term.id, TermDto.fromState(action.term));
        yield UpdateTermAction(TermState.fromDto(result.data));
      } catch (e) {
        print(e);
      }
    });
  }
}
