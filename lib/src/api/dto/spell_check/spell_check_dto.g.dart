// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_check_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpellCheckDto _$SpellCheckDtoFromJson(Map<String, dynamic> json) {
  return SpellCheckDto(
    json['word'] as String,
    (json['s'] as List).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$SpellCheckDtoToJson(SpellCheckDto instance) =>
    <String, dynamic>{
      'word': instance.word,
      's': instance.strings,
    };
