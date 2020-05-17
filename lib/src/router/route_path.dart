import 'package:flutter/cupertino.dart';

class RoutePath {
  final String pattern;
  final Widget Function(Map<String, String>) builder;

  RoutePath(this.pattern, this.builder);
}
