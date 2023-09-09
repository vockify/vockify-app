import 'package:vockify/src/redux/actions/sets/request_add_user_set_action.dart';
import 'package:vockify/src/redux/actions/sets/request_remove_user_set_action.dart';
import 'package:vockify/src/redux/actions/sets/request_update_user_set_action.dart';
import 'package:vockify/src/redux/actions/terms/request_add_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/request_remove_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/request_update_user_term_action.dart';
import 'package:vockify/src/redux/middlewares/action_handlers_middleware.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/services/amplitude.dart';

class TrackingMiddleware extends ActionHandlersMiddleware<AppState> {
  List<ActionHandler<AppState, Object>> _handlers = [];

  TrackingMiddleware() {
    _handlers = [
      ActionHandler<AppState, RequestAddUserSetAction>(_trackSetAdded),
      ActionHandler<AppState, RequestRemoveUserSetAction>(_trackSetDeleted),
      ActionHandler<AppState, RequestUpdateUserSetAction>(_trackSetUpdated),
      ActionHandler<AppState, RequestAddUserTermAction>(_trackTermAdded),
      ActionHandler<AppState, RequestRemoveUserTermAction>(_trackTermDeleted),
      ActionHandler<AppState, RequestUpdateUserTermAction>(_trackTermUpdated),
    ];
  }

  @override
  Iterable<ActionHandler<AppState, Object>> get handlers => _handlers;

  void _trackSetAdded(
    AppState state,
    RequestAddUserSetAction action,
  ) {
    amplitude.logEvent('set_added', eventProperties: {
      'set_name': action.set.name,
    });
  }

  void _trackSetDeleted(
    AppState state,
    RequestRemoveUserSetAction action,
  ) {
    amplitude.logEvent('set_deleted', eventProperties: {
      'set_id': action.id,
    });
  }

  void _trackSetUpdated(
    AppState state,
    RequestUpdateUserSetAction action,
  ) {
    amplitude.logEvent('set_updated', eventProperties: {
      'set_id': action.set.id,
      'set_name': action.set.name,
    });
  }

  void _trackTermAdded(
    AppState state,
    RequestAddUserTermAction action,
  ) {
    amplitude.logEvent('term_added', eventProperties: {
      'term_id': action.term.id,
      'set_id': action.term.setId,
      'term_name': action.term.name,
      'term_definition': action.term.definition,
    });
  }

  void _trackTermDeleted(
    AppState state,
    RequestRemoveUserTermAction action,
  ) {
    amplitude.logEvent('term_deleted', eventProperties: {
      'term_id': action.id,
    });
  }

  void _trackTermUpdated(
    AppState state,
    RequestUpdateUserTermAction action,
  ) {
    amplitude.logEvent('term_updated', eventProperties: {
      'term_id': action.term.id,
      'set_id': action.term.setId,
      'term_name': action.term.name,
      'term_definition': action.term.definition,
    });
  }
}
