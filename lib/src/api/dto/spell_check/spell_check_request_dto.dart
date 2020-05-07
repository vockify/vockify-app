import 'package:json_annotation/json_annotation.dart';

part 'spell_check_request_dto.g.dart';

@JsonSerializable(nullable: false)
class SpellCheckRequestDto {
  final String text;
  final String lang;

  SpellCheckRequestDto(this.text, [this.lang = 'en']);

  factory SpellCheckRequestDto.fromJson(Map<String, dynamic> json) => _$SpellCheckRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SpellCheckRequestDtoToJson(this);
}
