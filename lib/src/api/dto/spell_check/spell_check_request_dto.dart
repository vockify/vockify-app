import 'package:json_annotation/json_annotation.dart';

part 'spell_check_request_dto.g.dart';

@JsonSerializable(createFactory: false)
class SpellCheckRequestDto {
  final String text;
  final String lang;

  SpellCheckRequestDto(this.text, [this.lang = 'en']);

  Map<String, dynamic> toJson() => _$SpellCheckRequestDtoToJson(this);
}
