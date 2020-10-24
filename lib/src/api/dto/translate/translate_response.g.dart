// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslateResponse _$TranslateResponseFromJson(Map<String, dynamic> json) {
  return TranslateResponse(
    TranslateDto.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TranslateResponseToJson(TranslateResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
