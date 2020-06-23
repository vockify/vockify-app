import 'dart:async';

import 'package:redux_epics/redux_epics.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/set_dto.dart';
import 'package:vockify/src/redux/actions/add_user_set.dart';
import 'package:vockify/src/redux/actions/remove_user_set_action.dart';
import 'package:vockify/src/redux/actions/request_add_set_action.dart';
import 'package:vockify/src/redux/actions/request_remove_set_action.dart';
import 'package:vockify/src/redux/actions/request_sets_action.dart';
import 'package:vockify/src/redux/actions/request_update_set_action.dart';
import 'package:vockify/src/redux/actions/set_added_user_set_action.dart';
import 'package:vockify/src/redux/actions/set_user_sets_action.dart';
import 'package:vockify/src/redux/actions/set_user_sets_loader.dart';
import 'package:vockify/src/redux/actions/update_user_set_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

class SetEffect {
  Epic<AppState> getEffects() {
    return combineEpics([
      TypedEpic<AppState, RequestSetsAction>(_requestSetsAction),
      TypedEpic<AppState, RequestAddSetAction>(_requestAddSetAction),
      TypedEpic<AppState, RequestUpdateSetAction>(_requestUpdateSetAction),
      TypedEpic<AppState, RequestRemoveSetAction>(_requestRemoveSetAction),
    ]);
  }

  Stream<Object> _requestAddSetAction(
    Stream<RequestAddSetAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield SetAddedUserSetAction(action.set);

      try {
        final result = await api.addSet(SetDto.fromState(action.set));

        if (store.state.sets.user.loader == LoaderState.isLoaded) {
          yield AddUserSetAction(SetState.fromDto(result.data));
        }
      } catch (e) {
        print(e);
      } finally {
        yield SetAddedUserSetAction(null);
      }
    });
  }

  Stream<Object> _requestRemoveSetAction(
    Stream<RequestRemoveSetAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield RemoveUserSetAction(action.payload);

      try {
        await api.deleteSet(action.payload);
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
      if (store.state.sets.user.loader == LoaderState.isLoaded) {
        yield SetUserSetsLoader(LoaderState.refresh);
      }

      try {
        final response = await api.getSets();
        yield SetUserSetsAction(response.data.map((dto) => SetState.fromDto(dto)));
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
      yield UpdateUserSetAction(action.set);

      try {
        final response = await api.updateSet(action.set.id, SetDto.fromState(action.set));
        yield UpdateUserSetAction(SetState.fromDto(response.data));
      } catch (e) {
        print(e);
      }
    });
  }
}
