// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DictionaryEntryDto _$DictionaryEntryDtoFromJson(Map<String, dynamic> json) {
  return DictionaryEntryDto(
    json['text'] as String,
    _$enumDecode(_$PartOfSpeechEnumMap, json['pos']),
    json['ts'] as String,
    (json['tr'] as List)
        .map((e) => TranslationDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DictionaryEntryDtoToJson(DictionaryEntryDto instance) =>
    <String, dynamic>{
      'text': instance.text,
      'pos': _$PartOfSpeechEnumMap[instance.partOfSpeech],
      'ts': instance.transcription,
      'tr': instance.translations,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

const _$PartOfSpeechEnumMap = {
  PartOfSpeech.Noun: 'noun',
  PartOfSpeech.Pronoun: 'pronoun',
  PartOfSpeech.Verb: 'verb',
  PartOfSpeech.Adjective: 'adjective',
  PartOfSpeech.Adverb: 'adverb',
  PartOfSpeech.Preposition: 'preposition',
  PartOfSpeech.Conjunction: 'conjunction',
  PartOfSpeech.Interjection: 'interjection',
};
