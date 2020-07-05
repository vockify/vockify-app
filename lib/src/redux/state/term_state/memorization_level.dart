import 'dart:collection';

class MemorizationLevel {
  static final UnmodifiableListView<MemorizationLevel> values = UnmodifiableListView([
    bad,
    good,
    great,
  ]);

  static const MemorizationLevel bad = const MemorizationLevel._('bad');
  static const MemorizationLevel good = const MemorizationLevel._('good');
  static const MemorizationLevel great = const MemorizationLevel._('great');

  final String name;

  factory MemorizationLevel(String name) => values.firstWhere((value) => value.name == name, orElse: () => null);

  const MemorizationLevel._(this.name);

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MemorizationLevel && runtimeType == other.runtimeType && name == other.name;

  @override
  String toString() => name;
}
