import 'package:built_value/built_value.dart';
import 'package:vockify/src/api/dto/terms/term_dto.dart';
import 'package:vockify/src/redux/state/term_state/memorization_level.dart';

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

      builder.memorizationLevel = MemorizationLevel(dto.memorizationLevel ?? '');
    });
  }

  TermState._();

  String get definition;

  int get id;

  String get name;

  int get setId;

  MemorizationLevel? get memorizationLevel;
}
