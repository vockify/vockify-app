import 'package:json_annotation/json_annotation.dart';

part 'translate_request_dto.g.dart';

@JsonSerializable(createToJson: false)
class TranslateRequestDto {
  final String text;

  TranslateRequestDto(this.text);

  factory TranslateRequestDto.fromJson(Map<String, dynamic> json) => _$TranslateRequestDtoFromJson(json);
}
