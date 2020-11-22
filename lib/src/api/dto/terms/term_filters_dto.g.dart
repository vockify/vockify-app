// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_filters_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermFiltersDto _$TermFiltersDtoFromJson(Map<String, dynamic> json) {
  return TermFiltersDto(
    setIds: (json['setIds'] as List).map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$TermFiltersDtoToJson(TermFiltersDto instance) =>
    <String, dynamic>{
      'setIds': instance.setIds,
    };
