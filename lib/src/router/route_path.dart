import 'package:flutter/cupertino.dart';
import 'package:vockify/src/router/router.dart';

class RoutePath {
  final String pattern;
  final Widget Function(Router) builder;

  RoutePath(this.pattern, this.builder);
}