import 'dart:collection';

class MemorizationLevel {
  static final UnmodifiableListView<MemorizationLevel> values = UnmodifiableListView([
    bad,
    good,
    great,
  ]);

  static final UnmodifiableListView<MemorizationLevel> sorted = UnmodifiableListView([
    bad,
    unknown,
    good,
    great,
  ]);

  static const MemorizationLevel unknown = const MemorizationLevel._(null);

  static const MemorizationLevel bad = const MemorizationLevel._('bad');
  static const MemorizationLevel good = const MemorizationLevel._('good');
  static const MemorizationLevel great = const MemorizationLevel._('great');

  final String name;

  factory MemorizationLevel(String name) => values.firstWhere((value) => value.name == name, orElse: () => unknown);

  const MemorizationLevel._(this.name);

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MemorizationLevel && runtimeType == other.runtimeType && name == other.name;

  @override
  String toString() => name;

  static MemorizationLevel down(MemorizationLevel level) {
    if (level == unknown) {
      return bad;
    }

    final index = values.indexOf(level);

    try {
      return values[index - 1];
    } catch (e) {
      return values.first;
    }
  }

  static MemorizationLevel up(MemorizationLevel memorizationLevel) {
    if (memorizationLevel == unknown) {
      return good;
    }

    final index = values.indexOf(memorizationLevel);

    try {
      return values[index + 1];
    } catch (e) {
      return values.last;
    }
  }

  static int compare(MemorizationLevel a, MemorizationLevel b) {
    if (sorted.indexOf(a) > sorted.indexOf(b)) {
      return 1;
    } else if (sorted.indexOf(a) < sorted.indexOf(b)) {
      return -1;
    } else {
      return 0;
    }
  }
}
