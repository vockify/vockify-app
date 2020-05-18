// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetDto _$SetDtoFromJson(Map<String, dynamic> json) {
  return SetDto(
    json['id'] as int,
    json['name'] as String,
    json['icon'] as String,
    json['terms_count'] as int ?? 0,
  );
}

Map<String, dynamic> _$SetDtoToJson(SetDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'terms_count': instance.termsCount,
    };
