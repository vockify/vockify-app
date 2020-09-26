// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translate_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslateDto _$TranslateDtoFromJson(Map<String, dynamic> json) {
  return TranslateDto(
    json['term'] as String,
    json['transcription'] as String,
    (json['definitions'] as List).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$TranslateDtoToJson(TranslateDto instance) =>
    <String, dynamic>{
      'term': instance.term,
      'transcription': instance.transcription,
      'definitions': instance.definitions,
    };
