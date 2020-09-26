import 'package:json_annotation/json_annotation.dart';

part 'translate_dto.g.dart';

@JsonSerializable(nullable: false)
class TranslateDto {
  final String term;
  final String transcription;
  final List<String> definitions;

  TranslateDto(this.term, this.transcription, this.definitions);

  factory TranslateDto.fromJson(Map<String, dynamic> json) => _$TranslateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TranslateDtoToJson(this);
}
