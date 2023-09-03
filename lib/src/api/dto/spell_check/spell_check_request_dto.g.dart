// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_check_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpellCheckRequestDto _$SpellCheckRequestDtoFromJson(
        Map<String, dynamic> json) =>
    SpellCheckRequestDto(
      json['text'] as String,
      json['lang'] as String? ?? 'en',
    );

Map<String, dynamic> _$SpellCheckRequestDtoToJson(
        SpellCheckRequestDto instance) =>
    <String, dynamic>{
      'text': instance.text,
      'lang': instance.lang,
    };
