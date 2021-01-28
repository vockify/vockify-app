// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DictionaryEntryDto _$DictionaryEntryDtoFromJson(Map<String, dynamic> json) {
  return DictionaryEntryDto(
    json['text'] as String,
    json['pos'] as String,
    json['ts'] as String,
    (json['tr'] as List)
        .map((e) => TranslationDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DictionaryEntryDtoToJson(DictionaryEntryDto instance) =>
    <String, dynamic>{
      'text': instance.text,
      'pos': instance.partOfSpeech,
      'ts': instance.transcription,
      'tr': instance.translations,
    };
