// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TermModelImpl _$$TermModelImplFromJson(Map<String, dynamic> json) =>
    _$TermModelImpl(
      id: json['id'] as int,
      setId: json['setId'] as int,
      name: json['name'] as String,
      definition: json['definition'] as String,
      memorizationLevel: json['memorizationLevel'] == null
          ? null
          : MemorizationLevel.fromJson(json['memorizationLevel'] as String),
    );

Map<String, dynamic> _$$TermModelImplToJson(_$TermModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'setId': instance.setId,
      'name': instance.name,
      'definition': instance.definition,
      'memorizationLevel': instance.memorizationLevel,
    };
