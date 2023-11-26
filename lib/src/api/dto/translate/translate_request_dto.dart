import 'package:json_annotation/json_annotation.dart';

part 'translate_request_dto.g.dart';

@JsonSerializable(createFactory: false)
class TranslateRequestDto {
  final String text;

  TranslateRequestDto(this.text);

  Map<String, dynamic> toJson() => _$TranslateRequestDtoToJson(this);
}
