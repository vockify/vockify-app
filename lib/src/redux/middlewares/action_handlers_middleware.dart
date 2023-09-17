import 'package:redux/redux.dart';
import 'package:collection/collection.dart';

class ActionHandler<TActionScopeState, Action> {
  final void Function(TActionScopeState, Action) _handler;

  ActionHandler(this._handler);

  void handler(dynamic state, dynamic action) {
    _handler(state as TActionScopeState, action as Action);
  }

  bool handlesAction(dynamic action) => action is Action;
}

abstract class ActionHandlersMiddleware<TState> extends MiddlewareClass<TState> {
  Iterable<ActionHandler<TState, Object>> get handlers;

  @override
  dynamic call(Store<TState> store, dynamic action, NextDispatcher next) {
    final handler = handlers.firstWhereOrNull((handler) => handler.handlesAction(action));
    handler?.handler(store.state, action);

    next(action);
  }
}
