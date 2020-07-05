import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/api/dto/translate/translate_dto.dart';

part 'translate_response.g.dart';

@JsonSerializable(nullable: false)
class TranslateResponse {
  final List<TranslateDto> data;

  TranslateResponse(this.data);

  factory TranslateResponse.fromJson(Map<String, dynamic> json) =>
      _$TranslateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TranslateResponseToJson(this);
}
