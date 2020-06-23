import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

part 'term_dto.g.dart';

@JsonSerializable(nullable: false)
class TermDto {
  final int id;

  final String name;

  final String definition;

  @JsonKey(name: 'set_id')
  final int setId;

  TermDto(this.id, this.name, this.definition, this.setId);

  factory TermDto.fromJson(Map<String, dynamic> json) => _$TermDtoFromJson(json);

  factory TermDto.fromState(TermState state) {
    return TermDto(
      state.id,
      state.name,
      state.definition,
      state.setId,
    );
  }

  Map<String, dynamic> toJson() => _$TermDtoToJson(this);
}
