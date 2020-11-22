// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_filters_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetFiltersDto _$SetFiltersDtoFromJson(Map<String, dynamic> json) {
  return SetFiltersDto(
    userIds: (json['userIds'] as List).map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$SetFiltersDtoToJson(SetFiltersDto instance) =>
    <String, dynamic>{
      'userIds': instance.userIds,
    };
