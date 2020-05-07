import 'package:json_annotation/json_annotation.dart';

part 'translate_request_dto.g.dart';

@JsonSerializable(nullable: false)
class TranslateRequestDto {
  final String text;

  TranslateRequestDto(this.text);

  factory TranslateRequestDto.fromJson(Map<String, dynamic> json) => _$TranslateRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TranslateRequestDtoToJson(this);
}
