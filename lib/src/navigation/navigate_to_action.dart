import 'package:flutter/widgets.dart';

/// Controls the type of navigation method.
enum NavigationType {
  /// The [Navigator.pushReplacementNamed] will be called.
  shouldReplace,

  /// The [Navigator.pop] will be called.
  shouldPop,

  /// The [Navigator.pushNamed] will be called.
  shouldPush,

  /// The [Navigator.pushNamedAndRemoveUntil] will be called.
  shouldPushNamedAndRemoveUntil,

  /// The [Navigator.popUntil] will be called
  shouldPopUntil
}

/// The action to be dispatched in the store in order to trigger a navigation.
class NavigateToAction {
  final String? name;

  /// Controls the method to be called on the [Navigator] with the specified
  /// [name].
  final NavigationType type;

  /// Optional callback function to be called before the actual navigation.
  /// e.g. activate the loader.
  final Function? preNavigation;

  /// Optional callback function to be called after the actual navigation.
  /// e.g. de-activate the loader.
  final Function? postNavigation;

  /// Optional object to be passed either in [NavigationType.shouldPush] or
  /// [NavigationType.shouldReplace].
  ///
  /// It will be ignored if passed with type [NavigationType.shouldPop]
  final Object? arguments;

  /// Optional object to be passed either in [NavigationType.shouldPushNamedAndRemoveUntil]
  /// or in [NavigationType.shouldPopUntil]
  ///
  /// It will be ignored if passed with any other type.
  final RoutePredicate? predicate;

  final VoidCallback? onPop;

  final NavigatorState? currentState;

  /// Create a navigation action.
  ///
  /// The [name] parameter must not be null.
  /// The [preNavigation] and [postNavigation] parameters are optional.
  NavigateToAction(this.name,
      {this.type = NavigationType.shouldPush,
      this.preNavigation,
      this.postNavigation,
      this.arguments,
      this.predicate,
      this.onPop,
      this.currentState})
      : assert(() {
          if (type == NavigationType.shouldPushNamedAndRemoveUntil) {
            return predicate != null;
          }
          if (type == NavigationType.shouldPopUntil) {
            return predicate != null;
          }
          if (type != NavigationType.shouldPop) {
            return name != null && name.isNotEmpty;
          }
          return true;
        }());

  factory NavigateToAction.push(String name,
          {Function? preNavigation,
          Function? postNavigation,
          Object? arguments,
          VoidCallback? onPop,
          NavigatorState? currentState}) =>
      NavigateToAction(name,
          preNavigation: preNavigation,
          postNavigation: postNavigation,
          arguments: arguments,
          onPop: onPop,
          currentState: currentState);

  factory NavigateToAction.pop({Function? preNavigation, Function? postNavigation, NavigatorState? currentState}) =>
      NavigateToAction(null,
          type: NavigationType.shouldPop,
          preNavigation: preNavigation,
          postNavigation: postNavigation,
          currentState: currentState);

  factory NavigateToAction.popUntil({Function? preNavigation, Function? postNavigation, RoutePredicate? predicate}) =>
      NavigateToAction(null,
          type: NavigationType.shouldPopUntil,
          preNavigation: preNavigation,
          postNavigation: postNavigation,
          predicate: predicate);

  factory NavigateToAction.replace(String name,
          {Function? preNavigation,
          Function? postNavigation,
          Object? arguments,
          VoidCallback? onPop,
          NavigatorState? currentState}) =>
      NavigateToAction(name,
          type: NavigationType.shouldReplace,
          preNavigation: preNavigation,
          postNavigation: postNavigation,
          arguments: arguments,
          onPop: onPop,
          currentState: currentState);

  factory NavigateToAction.pushNamedAndRemoveUntil(String name, RoutePredicate predicate,
          {Function? preNavigation,
          Function? postNavigation,
          Object? arguments,
          VoidCallback? onPop,
          NavigatorState? currentState}) =>
      NavigateToAction(name,
          type: NavigationType.shouldPushNamedAndRemoveUntil,
          preNavigation: preNavigation,
          postNavigation: postNavigation,
          predicate: predicate,
          arguments: arguments,
          onPop: onPop,
          currentState: currentState);
}
