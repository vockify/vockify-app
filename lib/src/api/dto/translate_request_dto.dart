import 'package:json_annotation/json_annotation.dart';

part 'translate_request_dto.g.dart';

@JsonSerializable(nullable: false)
class TranslateRequestDto {
  final List<String> words;

  TranslateRequestDto(this.words);

  factory TranslateRequestDto.fromJson(Map<String, dynamic> json) => _$TranslateRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TranslateRequestDtoToJson(this);
}
