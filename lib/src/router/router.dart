import 'package:flutter/cupertino.dart';
import 'package:path_to_regexp/path_to_regexp.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/route_path.dart';

class Router {
  final RoutePath route;
  final RouteSettings settings;
  final Store<AppState> store;
  RegExp _regExp;

  List<String> _parameters = <String>[];

  Router._(this.route, this.settings, this.store);

  factory Router(RoutePath route, RouteSettings settings, Store<AppState> store) {
    return Router._(route, settings, store).init();
  }

  Router init() {
    _regExp = pathToRegExp(route.pattern, parameters: _parameters);

    return this;
  }

  bool matches() {
    return _regExp.hasMatch(settings.name);
  }

  Map<String, String> _arguments() {
    final match = _regExp.matchAsPrefix(settings.name);

    return extract(_parameters, match);
  }

  String getQueryArgument(String key) {
    final arguments = _arguments();

    if (!arguments.containsKey(key)) {
      throw new ArgumentError("Route param:'$key' does not present");
    }

    return arguments[key];
  }

  static String routeToPath(String route, Map<String, String> params) {
    final toPath = pathToFunction(route);

    return toPath(params);
  }
}
