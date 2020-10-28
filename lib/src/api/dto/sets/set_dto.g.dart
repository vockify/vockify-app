// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetDto _$SetDtoFromJson(Map<String, dynamic> json) {
  return SetDto(
    id: json['id'] as int,
    name: json['name'] as String,
    parentId: json['parent_set_id'] as int,
    icon: json['icon'] as String,
    type: json['type'] as String,
    terms: SetTermsDto.fromJson(json['terms'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SetDtoToJson(SetDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'parent_set_id': instance.parentId,
      'type': instance.type,
      'terms': instance.terms,
    };
