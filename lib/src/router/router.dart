import 'package:flutter/cupertino.dart';
import 'package:path_to_regexp/path_to_regexp.dart';
import 'package:vockify/src/router/route_path.dart';

class Router {
  final RoutePath route;
  final RouteSettings settings;

  RegExp _regExp;

  List<String> _parameters = <String>[];

  factory Router(RoutePath route, RouteSettings settings) {
    return Router._(route, settings).init();
  }

  Router._(this.route, this.settings);

  Map<String, String> getArguments() {
    if (settings.arguments == null) {
      final match = _regExp.matchAsPrefix(settings.name);
      return extract(_parameters, match);
    }

    if (settings.arguments is! Map<String, String>) {
      throw ArgumentError("arguments cast error");
    }

    return settings.arguments as Map<String, String>;
  }

  Router init() {
    _regExp = pathToRegExp(route.pattern, parameters: _parameters);

    return this;
  }

  bool matches() {
    if (route.pattern == settings.name) {
      return true;
    }

    return _regExp.hasMatch(settings.name);
  }
}
