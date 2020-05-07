import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/navigation/navigate_to_action.dart';
import 'package:vockify/src/navigation/navigation_destination.dart';
import 'package:vockify/src/navigation/navigation_holder.dart';
import 'package:vockify/src/navigation/navigation_state.dart';

class NavigationMiddleware<T> implements MiddlewareClass<T> {
  final NavigatorState currentState;

  NavigationMiddleware({this.currentState});

  @override
  void call(Store<T> store, dynamic action, NextDispatcher next) {
    if (action is NavigateToAction) {
      final navigationAction = action;
      final currentState =
          this.currentState ?? NavigatorHolder.navigatorKey.currentState;

      if (action.preNavigation != null) {
        action.preNavigation();
      }

      Future poppedFuture;

      switch (navigationAction.type) {
        case NavigationType.shouldReplace:
          poppedFuture = currentState.pushReplacementNamed(navigationAction.name,
              arguments: navigationAction.arguments);
          this._setState(NavigationDestination(navigationAction.name, navigationAction.arguments));
          break;
        case NavigationType.shouldPop:
          currentState.pop();
          this._setState(NavigatorHolder.state?.previousDestination);
          break;
        case NavigationType.shouldPopUntil:
          currentState.popUntil(navigationAction.predicate);
          this._setState(null);
          break;
        case NavigationType.shouldPushNamedAndRemoveUntil:
          poppedFuture = currentState.pushNamedAndRemoveUntil(
              navigationAction.name, navigationAction.predicate,
              arguments: navigationAction.arguments);
          this._setState(null);
          break;
        default:
          poppedFuture = currentState.pushNamed(navigationAction.name,
              arguments: navigationAction.arguments);
          this._setState(NavigationDestination(navigationAction.name, navigationAction.arguments));
      }

      if (action.postNavigation != null) {
        action.postNavigation();
      }

      if (action.onPop != null) {
        poppedFuture.then((_) {
          action.onPop();
        });
      }
    }

    next(action);
  }

  void _setState(NavigationDestination currentDestination) {
    NavigatorHolder.state = NavigationState.transition(
        NavigatorHolder.state?.currentDestination, currentDestination);
  }
}
