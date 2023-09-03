import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

part 'term_dto.g.dart';

@JsonSerializable()
class TermDto {
  final int id;

  final String name;

  final String definition;

  @JsonKey(name: 'set_id')
  final int setId;

  @JsonKey(name: 'memorization_level')
  final String? memorizationLevel;

  TermDto({
    required this.id,
    required this.name,
    required this.setId,
    required this.definition,
    this.memorizationLevel,
  });

  factory TermDto.fromJson(Map<String, dynamic> json) => _$TermDtoFromJson(json);

  factory TermDto.fromState(TermState state) {
    return TermDto(
      id: state.id,
      name: state.name,
      definition: state.definition,
      setId: state.setId,
      memorizationLevel: state.memorizationLevel.toString(),
    );
  }

  Map<String, dynamic> toJson() => _$TermDtoToJson(this);
}
