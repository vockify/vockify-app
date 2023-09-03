// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_filters_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermFiltersDto _$TermFiltersDtoFromJson(Map<String, dynamic> json) =>
    TermFiltersDto(
      userIds: (json['filter[user_id]'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      setIds: (json['filter[set_id]'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      perPage: json['per_page'] as int,
    );

Map<String, dynamic> _$TermFiltersDtoToJson(TermFiltersDto instance) =>
    <String, dynamic>{
      'filter[set_id]': TermFiltersDto.toCommaSeparatedList(instance.setIds),
      'filter[user_id]': TermFiltersDto.toCommaSeparatedList(instance.userIds),
      'per_page': instance.perPage,
    };
