// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_filters_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetFiltersDto _$SetFiltersDtoFromJson(Map<String, dynamic> json) =>
    SetFiltersDto(
      userIds: (json['filter[user_id]'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      terms: (json['filter[term]'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SetFiltersDtoToJson(SetFiltersDto instance) =>
    <String, dynamic>{
      'filter[user_id]': SetFiltersDto.toCommaSeparatedList(instance.userIds),
      'filter[term]': SetFiltersDto.toCommaSeparatedList(instance.terms),
    };
