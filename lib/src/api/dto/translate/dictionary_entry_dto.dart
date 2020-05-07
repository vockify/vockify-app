import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/api/dto/translate/translation_dto.dart';

part 'dictionary_entry_dto.g.dart';

@JsonSerializable(nullable: false)
class DictionaryEntryDto {
  @JsonKey(name: 'text')
  final String text;

  @JsonKey(name: 'pos')
  final String partOfSpeech;

  @JsonKey(name: 'ts')
  final String transcription;

  @JsonKey(name: 'tr')
  final List<TranslationDto> translations;

  DictionaryEntryDto(this.text, this.partOfSpeech, this.transcription, this.translations);

  factory DictionaryEntryDto.fromJson(Map<String, dynamic> json) => _$DictionaryEntryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DictionaryEntryDtoToJson(this);
}
