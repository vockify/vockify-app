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
    termsCount: json['terms_count'] as int ?? 0,
  );
}

Map<String, dynamic> _$SetDtoToJson(SetDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'parent_set_id': instance.parentId,
      'terms_count': instance.termsCount,
    };
