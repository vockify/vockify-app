import 'package:built_value/built_value.dart';
import 'package:vockify/src/api/dto/term_dto.dart';

part 'term_state.g.dart';

abstract class TermState implements Built<TermState, TermStateBuilder> {
  factory TermState([void updates(TermStateBuilder b)]) = _$TermState;

  factory TermState.fromDto(TermDto dto) {
    return TermState((builder) {
      builder
        ..definition = dto.definition
        ..name = dto.name
        ..id = dto.id
        ..setId = dto.setId;
    });
  }

  TermState._();

  String get definition;

  int get id;

  String get name;

  int get setId;
}
