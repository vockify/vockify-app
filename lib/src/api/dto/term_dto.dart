import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/redux/state/term_state.dart';

part 'term_dto.g.dart';

@JsonSerializable(nullable: false)
class TermDto {
  final int id;

  final String name;

  final String definition;

  TermDto(this.id, this.name, this.definition);

  factory TermDto.fromJson(Map<String, dynamic> json) => _$TermDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TermDtoToJson(this);

  TermState toState() => TermState((builder) {
    builder
      ..definition = definition
      ..name = name
      ..id = id;
  });
}
