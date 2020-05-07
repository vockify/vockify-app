// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_filters_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermFiltersDto _$TermFiltersDtoFromJson(Map<String, dynamic> json) {
  return TermFiltersDto(
    userIds: (json['filter[user_id]'] as List).map((e) => e as int).toList(),
    setIds: (json['filter[set_id]'] as List).map((e) => e as int).toList(),
    perPage: json['per_page'] as int,
  );
}

Map<String, dynamic> _$TermFiltersDtoToJson(TermFiltersDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'filter[set_id]', TermFiltersDto.toCommaSeparatedList(instance.setIds));
  writeNotNull(
      'filter[user_id]', TermFiltersDto.toCommaSeparatedList(instance.userIds));
  writeNotNull('per_page', instance.perPage);
  return val;
}
