import 'package:json_annotation/json_annotation.dart';

part 'translate_dto.g.dart';

@JsonSerializable(nullable: false)
class TranslateDto {
  @JsonKey(name: 'Text')
  final String text;

  TranslateDto(this.text);

  factory TranslateDto.fromJson(Map<String, dynamic> json) => _$TranslateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TranslateDtoToJson(this);
}
