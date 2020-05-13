// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translate_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslateRequestDto _$TranslateRequestDtoFromJson(Map<String, dynamic> json) {
  return TranslateRequestDto(
    (json['words'] as List).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$TranslateRequestDtoToJson(
        TranslateRequestDto instance) =>
    <String, dynamic>{
      'words': instance.words,
    };
