import 'package:json_annotation/json_annotation.dart';

part 'term_filters_dto.g.dart';

@JsonSerializable(nullable: false)
class TermFiltersDto {
  @JsonKey(name: "filter[set_id]", toJson: toCommaSeparatedList)
  final List<int> setIds;

  TermFiltersDto({
    this.setIds
  });

  static String toCommaSeparatedList(List<int> list) => list.join(',');

  Map<String, dynamic> toJson() => _$TermFiltersDtoToJson(this);

  factory TermFiltersDto.fromJson(Map<String, dynamic> json) => _$TermFiltersDtoFromJson(json);
}
