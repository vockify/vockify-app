// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslateResponse _$TranslateResponseFromJson(Map<String, dynamic> json) {
  return TranslateResponse(
    (json['data'] as List)
        .map((e) => DictionaryEntryDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TranslateResponseToJson(TranslateResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
