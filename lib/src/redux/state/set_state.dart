import 'package:built_value/built_value.dart';

part 'set_state.g.dart';

abstract class SetState implements Built<SetState, SetStateBuilder> {
  factory SetState([void updates(SetStateBuilder b)]) = _$SetState;

  SetState._();

  int get id;
  String get name;
  String get icon;
}
