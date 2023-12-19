// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SetModelImpl _$$SetModelImplFromJson(Map<String, dynamic> json) =>
    _$SetModelImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      isDefault: json['isDefault'] as bool,
      terms: TermsModel.fromJson(json['terms'] as Map<String, dynamic>),
      parentId: json['parentId'] as int?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$$SetModelImplToJson(_$SetModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isDefault': instance.isDefault,
      'terms': instance.terms,
      'parentId': instance.parentId,
      'icon': instance.icon,
    };
