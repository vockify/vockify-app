import 'package:built_value/built_value.dart';

part 'term_state.g.dart';

abstract class TermState implements Built<TermState, TermStateBuilder> {
  factory TermState([void updates(TermStateBuilder b)]) = _$TermState;

  TermState._();

  int get id;

  String get name;

  String get definition;
}
