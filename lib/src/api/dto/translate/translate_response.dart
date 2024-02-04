import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/api/dto/translate/dictionary_entry_dto.dart';

part 'translate_response.g.dart';

@JsonSerializable(createToJson: false)
class TranslateResponse {
  final List<DictionaryEntryDto> def;

  TranslateResponse(this.def);

  factory TranslateResponse.fromJson(Map<String, dynamic> json) =>
      _$TranslateResponseFromJson(json);
}
