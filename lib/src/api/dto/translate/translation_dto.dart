import 'package:json_annotation/json_annotation.dart';

part 'translation_dto.g.dart';

@JsonSerializable()
class TranslationDto {
  final String text;

  TranslationDto(this.text);

  factory TranslationDto.fromJson(Map<String, dynamic> json) => _$TranslationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationDtoToJson(this);
}
