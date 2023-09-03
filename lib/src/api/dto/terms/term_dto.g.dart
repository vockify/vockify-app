// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermDto _$TermDtoFromJson(Map<String, dynamic> json) => TermDto(
      id: json['id'] as int,
      name: json['name'] as String,
      setId: json['set_id'] as int,
      definition: json['definition'] as String,
      memorizationLevel: json['memorization_level'] as String,
    );

Map<String, dynamic> _$TermDtoToJson(TermDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'definition': instance.definition,
      'set_id': instance.setId,
      'memorization_level': instance.memorizationLevel,
    };
