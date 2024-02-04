import 'package:vockify/src/navigation/navigation_path.dart';

/// It keeps the current and previous path of the navigation.
class NavigationState {
  final NavigationPath? previousDestination;
  final NavigationPath? currentDestination;

  @Deprecated('Use previousDestination.path instead')
  String? get previousPath => previousDestination?.path;

  @Deprecated('Use currentDestination.path instead')
  String? get currentPath => currentDestination?.path;

  NavigationState(this.previousDestination, this.currentDestination);

  factory NavigationState.initial() => NavigationState(null, null);

  factory NavigationState.transition(NavigationPath? previousDestination, NavigationPath? currentDestination) =>
      NavigationState(previousDestination, currentDestination);
}
