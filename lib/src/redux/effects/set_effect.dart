import 'dart:async';

import 'package:redux_epics/redux_epics.dart';
import 'package:vockify/src/api/dto/sets/set_dto.dart';
import 'package:vockify/src/api/dto/sets/set_filters_dto.dart';
import 'package:vockify/src/database/data_service.dart';
import 'package:vockify/src/navigation/navigate_to_action.dart';
import 'package:vockify/src/redux/actions/set_is_loading_action.dart';
import 'package:vockify/src/redux/actions/sets/add_user_set.dart';
import 'package:vockify/src/redux/actions/sets/remove_user_set_action.dart';
import 'package:vockify/src/redux/actions/sets/request_add_user_set_action.dart';
import 'package:vockify/src/redux/actions/sets/request_copy_set_action.dart';
import 'package:vockify/src/redux/actions/sets/request_remove_user_set_action.dart';
import 'package:vockify/src/redux/actions/sets/request_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/request_update_user_set_action.dart';
import 'package:vockify/src/redux/actions/sets/set_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/update_set_action.dart';
import 'package:vockify/src/redux/actions/unset_is_loading_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';
import 'package:vockify/src/router/routes.dart';

class SetEffect {
  Epic<AppState> getEffects() {
    return combineEpics([
      TypedEpic<AppState, RequestSetsAction>(_requestSetsAction),
      TypedEpic<AppState, RequestCopySetAction>(_requestCopySetAction),
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
        final id = await dataService.addSet(action.set);

        yield AddUserSetAction(set: SetState.fromDto(SetDto(
          id: id,
          name: action.set.name,
          icon: action.set.icon,
          parentId: action.set.parentId,
          terms: action.set.terms,
          isDefault: action.set.isDefault,
        )));
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
        final result = await dataService.copySet(action.id);
        yield AddUserSetAction(set: SetState.fromDto(result));
        yield NavigateToAction.push(Routes.quiz, arguments: {'setId': result.id});
      } finally {
        yield UnsetIsLoadingAction();
      }
    });
  }

  Stream<Object> _requestRemoveUserSetAction(
    Stream<RequestRemoveUserSetAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield RemoveUserSetAction(id: action.id);

      await dataService.deleteSet(action.id);
    });
  }

  Stream<Object> _requestUpdateUserSetAction(
    Stream<RequestUpdateUserSetAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield SetIsLoadingAction();

      try {
        final result = await dataService.updateSet(action.set);

        if (result) {
          yield UpdateSetAction(set: SetState.fromDto(action.set));
        }
      } finally {
        yield UnsetIsLoadingAction();
      }
    });
  }

  Stream<Object> _requestSetsAction(
    Stream<RequestSetsAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      final response = await dataService.getSets(SetFiltersDto());
      yield SetSetsAction(sets: response.map((dto) => SetState.fromDto(dto)));
    });
  }
}
