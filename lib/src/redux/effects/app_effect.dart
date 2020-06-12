import 'dart:async';

import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/redux/actions/add_set_action.dart';
import 'package:vockify/src/redux/actions/add_term_action.dart';
import 'package:vockify/src/redux/actions/authorize_action.dart';
import 'package:vockify/src/redux/actions/remove_set_action.dart';
import 'package:vockify/src/redux/actions/remove_term_action.dart';
import 'package:vockify/src/redux/actions/request_add_set_action.dart';
import 'package:vockify/src/redux/actions/request_add_term_action.dart';
import 'package:vockify/src/redux/actions/request_authorize_action.dart';
import 'package:vockify/src/redux/actions/request_data_action.dart';
import 'package:vockify/src/redux/actions/request_remove_set_action.dart';
import 'package:vockify/src/redux/actions/request_remove_term_action.dart';
import 'package:vockify/src/redux/actions/request_set_terms_action.dart';
import 'package:vockify/src/redux/actions/request_sets_action.dart';
import 'package:vockify/src/redux/actions/request_update_set_action.dart';
import 'package:vockify/src/redux/actions/request_update_term_action.dart';
import 'package:vockify/src/redux/actions/set_is_loading_action.dart';
import 'package:vockify/src/redux/actions/set_sets_action.dart';
import 'package:vockify/src/redux/actions/set_terms_action.dart';
import 'package:vockify/src/redux/actions/set_user_action.dart';
import 'package:vockify/src/redux/actions/unauthorize_action.dart';
import 'package:vockify/src/redux/actions/unset_is_loading_action.dart';
import 'package:vockify/src/redux/actions/update_set_action.dart';
import 'package:vockify/src/redux/actions/update_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/user_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/services/app_storage/app_storage.dart';
import 'package:vockify/src/services/authorization/authorization.dart';

class AppEffect {
  Epic<AppState> getEffects() {
    return combineEpics([
      TypedEpic<AppState, UnauthorizeAction>(_unauthorizeAction),
      TypedEpic<AppState, RequestAuthorizeAction>(_requestAuthorizeAction),
      TypedEpic<AppState, RequestDataAction>(_requestDataAction),
      TypedEpic<AppState, RequestSetsAction>(_requestSetsAction),
      TypedEpic<AppState, RequestAddSetAction>(_requestAddSetAction),
      TypedEpic<AppState, RequestUpdateSetAction>(_requestUpdateSetAction),
      TypedEpic<AppState, RequestRemoveSetAction>(_requestRemoveSetAction),
      TypedEpic<AppState, RequestSetTermsAction>(_requestSetTermsAction),
      TypedEpic<AppState, RequestAddTermAction>(_requestAddTermAction),
      TypedEpic<AppState, RequestUpdateTermAction>(_requestUpdateTermAction),
      TypedEpic<AppState, RequestRemoveTermAction>(_requestRemoveTermAction),
      TypedEpic<AppState, NavigateToAction>(_navigateToAction),
    ]);
  }

  Stream<Object> _navigateToAction(
    Stream<NavigateToAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      if (action.name != '/login' && action.name != '/tour' && !store.state.isAuthorized) {
        yield NavigateToAction.pushNamedAndRemoveUntil(Routes.login, (route) => false);
      } else if (action.name == '/login' && store.state.isAuthorized) {
        yield NavigateToAction.pushNamedAndRemoveUntil(Routes.sets, (route) => false);
      }
    });
  }

  Stream<Object> _requestAddSetAction(
    Stream<RequestAddSetAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      try {
        final set = await api.addSet(action.payload);
        yield AddSetAction(set.data.toState());
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<Object> _requestAuthorizeAction(
    Stream<RequestAuthorizeAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield SetIsLoadingAction();

      try {
        final authorization = Authorization.getInstance();
        await authorization.authenticate();
        yield AuthorizeAction();
        yield RequestDataAction(route: Routes.sets);
      } catch (e) {
        yield NavigateToAction.pushNamedAndRemoveUntil(Routes.login, (route) => false);
        print(e);
      } finally {
        yield UnsetIsLoadingAction();
      }
    });
  }

  Stream<Object> _requestRemoveSetAction(
    Stream<RequestRemoveSetAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield RemoveSetAction(action.payload);

      try {
        await api.deleteSet(action.payload);
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<Object> _requestRemoveTermAction(
      Stream<RequestRemoveTermAction> actions,
      EpicStore<AppState> store,
      ) {
    return actions.asyncExpand((action) async* {
      yield RemoveTermAction(action.payload);

      try {
        await api.deleteTerm(action.payload);
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<Object> _requestSetsAction(
    Stream<RequestSetsAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      try {
        final sets = await api.getSets();
        yield SetSetsAction(sets.toState());
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<Object> _requestSetTermsAction(
    Stream<RequestSetTermsAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      try {
        yield SetIsLoadingAction();
        final terms = await api.getSetTerms(action.payload);
        yield SetTermsAction(terms.toState());
      } catch (e) {
        print(e);
      } finally {
        yield UnsetIsLoadingAction();
      }
    });
  }

  Stream<Object> _requestAddTermAction(
      Stream<RequestAddTermAction> actions,
      EpicStore<AppState> store,
      ) {
    return actions.asyncExpand((action) async* {
      yield SetIsLoadingAction();

      try {
        final term = await api.addTerm(action.payload);
        yield AddTermAction(term.data.toState());
      } catch (e) {
        print(e);
      } finally {
        yield UnsetIsLoadingAction();
      }
    });
  }

  Stream<Object> _requestUpdateTermAction(
      Stream<RequestUpdateTermAction> actions,
      EpicStore<AppState> store,
      ) {
    return actions.asyncExpand((action) async* {
      try {
        final term = await api.updateTerm(action.payload.id, action.payload);
        yield UpdateTermAction(term.data.toState());
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<Object> _requestUpdateSetAction(
      Stream<RequestUpdateSetAction> actions,
      EpicStore<AppState> store,
      ) {
    return actions.asyncExpand((action) async* {
      try {
        final set = await api.updateSet(action.payload.id, action.payload);
        yield UpdateSetAction(set.data.toState());
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<Object> _requestDataAction(
    Stream<RequestDataAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield SetIsLoadingAction();

      try {
        final user = await api.authUser();
        yield SetUserAction(UserState.fromDto(user.data));
        final sets = await api.getSets();
        yield SetSetsAction(sets.toState());
        yield NavigateToAction.pushNamedAndRemoveUntil(action.route, (route) => false);
      } catch (e) {
        print(e);
      } finally {
        yield UnsetIsLoadingAction();
      }
    });
  }

  Stream<Object> _unauthorizeAction(
    Stream<UnauthorizeAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((event) async* {
      final storage = AppStorage.getInstance();
      await storage.remove('token');

      yield NavigateToAction.pushNamedAndRemoveUntil(Routes.login, (route) => false);
    });
  }
}
