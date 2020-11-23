// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_filters_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermFiltersDto _$TermFiltersDtoFromJson(Map<String, dynamic> json) {
  return TermFiltersDto(
    setIds: (json['filter[set_id]'] as List).map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$TermFiltersDtoToJson(TermFiltersDto instance) =>
    <String, dynamic>{
      'filter[set_id]': TermFiltersDto.toCommaSeparatedList(instance.setIds),
    };
