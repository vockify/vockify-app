// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermDto _$TermDtoFromJson(Map<String, dynamic> json) {
  return TermDto(
    json['id'] as int,
    json['name'] as String,
    json['definition'] as String,
    json['set_id'] as int,
  );
}

Map<String, dynamic> _$TermDtoToJson(TermDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'definition': instance.definition,
      'set_id': instance.setId,
    };
