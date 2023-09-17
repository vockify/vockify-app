import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/navigation/navigate_to_action.dart';
import 'package:vockify/src/navigation/navigation_path.dart';
import 'package:vockify/src/navigation/navigation_holder.dart';
import 'package:vockify/src/navigation/navigation_state.dart';

class NavigationMiddleware<T> implements MiddlewareClass<T> {
  final NavigatorState? currentState;

  NavigationMiddleware({this.currentState});

  @override
  void call(Store<T> store, dynamic action, NextDispatcher next) {
    if (action is NavigateToAction) {
      final navigationAction = action;

      final currentState =
          this.currentState ?? NavigatorHolder.navigatorKey.currentState;

      action.preNavigation?.call();

      Future<Object?>? poppedFuture;

      final name = navigationAction.name;

      switch (navigationAction.type) {
        case NavigationType.shouldReplace:
          if (name != null) {
            poppedFuture = currentState!.pushReplacementNamed(
              name,
              arguments: navigationAction.arguments,
            );
            this._setState(NavigationPath(navigationAction.name, navigationAction.arguments));
          }
          break;
        case NavigationType.shouldPop:
          currentState!.pop();
          this._setState(NavigatorHolder.state?.previousDestination);
          break;
        case NavigationType.shouldPopUntil:
          if (navigationAction.predicate != null) currentState!.popUntil(navigationAction.predicate!);
          this._setState(null);
          break;
        case NavigationType.shouldPushNamedAndRemoveUntil:
          if (navigationAction.predicate != null && navigationAction.name != null)
            poppedFuture = currentState!.pushNamedAndRemoveUntil(
              navigationAction.name!,
              navigationAction.predicate!,
              arguments: navigationAction.arguments,
            );
          this._setState(null);
          break;
        default:
          if (navigationAction.name != null)
            poppedFuture = currentState!.pushNamed(
              navigationAction.name!,
              arguments: navigationAction.arguments,
            );
          this._setState(NavigationPath(navigationAction.name, navigationAction.arguments));
      }

      if (action.postNavigation != null) {
        action.postNavigation!();
      }

      if (action.onPop != null && poppedFuture != null) {
        poppedFuture.then((_) {
          action.onPop!();
        });
      }
    }

    next(action);
  }

  void _setState(NavigationPath? currentDestination) {
    if (currentDestination == null) return;
    NavigatorHolder.state = NavigationState.transition(NavigatorHolder.state?.currentDestination, currentDestination);
  }
}
