import 'dart:async';

import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/sets/set_dto.dart';
import 'package:vockify/src/redux/actions/set_is_loading_action.dart';
import 'package:vockify/src/redux/actions/sets/add_user_set.dart';
import 'package:vockify/src/redux/actions/sets/remove_user_set_action.dart';
import 'package:vockify/src/redux/actions/sets/request_add_user_set_action.dart';
import 'package:vockify/src/redux/actions/sets/request_copy_set_action.dart';
import 'package:vockify/src/redux/actions/sets/request_public_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/request_remove_user_set_action.dart';
import 'package:vockify/src/redux/actions/sets/request_update_user_set_action.dart';
import 'package:vockify/src/redux/actions/sets/request_user_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/set_public_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/set_user_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/update_set_action.dart';
import 'package:vockify/src/redux/actions/unset_is_loading_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';
import 'package:vockify/src/router/routes.dart';

class SetEffect {
  Epic<AppState> getEffects() {
    return combineEpics([
      TypedEpic<AppState, RequestUserSetsAction>(_requestUserSetsAction),
      TypedEpic<AppState, RequestCopySetAction>(_requestCopySetAction),
      TypedEpic<AppState, RequestPublicSetsAction>(_requestPublicSetsAction),
      TypedEpic<AppState, RequestAddUserSetAction>(_requestAddUserSetAction),
      TypedEpic<AppState, RequestUpdateUserSetAction>(_requestUpdateUserSetAction),
      TypedEpic<AppState, RequestRemoveUserSetAction>(_requestRemoveUserSetAction),
    ]);
  }

  Stream<Object> _requestAddUserSetAction(
    Stream<RequestAddUserSetAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield SetIsLoadingAction();

      try {
        final result = await api.addSet(action.set);

        if (store.state.sets.user.loader == LoaderState.isLoaded) {
          yield AddUserSetAction(set: SetState.fromDto(result.data));
        }
      } catch (e) {
        print(e);
      } finally {
        yield UnsetIsLoadingAction();
      }
    });
  }

  Stream<Object> _requestCopySetAction(
    Stream<RequestCopySetAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield SetIsLoadingAction();

      try {
        final response = await api.copySet(action.id);
        yield AddUserSetAction(set: SetState.fromDto(response.data));
        yield NavigateToAction.push(Routes.quiz, arguments: {'setId': action.id});
      } catch (e) {
        print(e);
      } finally {
        yield UnsetIsLoadingAction();
      }
    });
  }

  Stream<Object> _requestPublicSetsAction(
    Stream<RequestPublicSetsAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      try {
        final response = await api.getPublicSets();
        yield SetPublicSetsAction(sets: response.data.map((dto) => SetState.fromDto(dto)));
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<Object> _requestRemoveUserSetAction(
    Stream<RequestRemoveUserSetAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield RemoveUserSetAction(id: action.id);

      try {
        await api.deleteSet(action.id);
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<Object> _requestUpdateUserSetAction(
    Stream<RequestUpdateUserSetAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield SetIsLoadingAction();

      try {
        final response = await api.updateSet(action.set.id, action.set);
        yield UpdateSetAction(set: SetState.fromDto(response.data));
      } catch (e) {
        print(e);
      } finally {
        yield UnsetIsLoadingAction();
      }
    });
  }

  Stream<Object> _requestUserSetsAction(
    Stream<RequestUserSetsAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      try {
        final response = await api.getUserSets();
        yield SetUserSetsAction(sets: response.data.map((dto) => SetState.fromDto(dto)));
      } catch (e) {
        print(e);
      }
    });
  }
}
