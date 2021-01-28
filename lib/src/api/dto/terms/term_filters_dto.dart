import 'package:json_annotation/json_annotation.dart';

part 'term_filters_dto.g.dart';

@JsonSerializable(nullable: false)
class TermFiltersDto {
  @JsonKey(name: "filter[set_id]", toJson: toCommaSeparatedList, includeIfNull: false)
  final List<int> setIds;

  @JsonKey(name: "filter[user_id]", toJson: toCommaSeparatedList, includeIfNull: false)
  final List<int> userIds;

  @JsonKey(name: "per_page", nullable: true, includeIfNull: false)
  final int perPage;

  TermFiltersDto({
    this.userIds,
    this.setIds,
    this.perPage,
  });

  factory TermFiltersDto.fromJson(Map<String, dynamic> json) => _$TermFiltersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TermFiltersDtoToJson(this);

  static String toCommaSeparatedList(List<int> list) => list != null ? list.join(',') : null;
}
