import 'package:json_annotation/json_annotation.dart';

part 'term_filters_dto.g.dart';

@JsonSerializable(nullable: false)
class TermFiltersDto {
  final List<int> setIds;

  TermFiltersDto({
    this.setIds
  });

  factory TermFiltersDto.fromJson(Map<String, dynamic> json) => _$TermFiltersDtoFromJson(json);

  Map<String, String> toJson() => {
    'filter[set_id]': setIds.join(','),
  };
}
