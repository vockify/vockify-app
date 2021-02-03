import 'package:json_annotation/json_annotation.dart';

part 'spell_check_dto.g.dart';

@JsonSerializable(nullable: false)
class SpellCheckDto {
  final String word;

  @JsonKey(name: 's')
  final List<String> strings;

  SpellCheckDto(this.word, this.strings);

  factory SpellCheckDto.fromJson(Map<String, dynamic> json) => _$SpellCheckDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SpellCheckDtoToJson(this);
}
