import 'package:json_annotation/json_annotation.dart';

part 'set_filters_dto.g.dart';

@JsonSerializable(nullable: false)
class SetFiltersDto {
  @JsonKey(name: "filter[user_id]", toJson: toCommaSeparatedList)
  final List<int> userIds;

  SetFiltersDto({
    this.userIds
  });

  static String toCommaSeparatedList(List<int> list) => list.join(',');

  Map<String, dynamic> toJson() => _$SetFiltersDtoToJson(this);

  factory SetFiltersDto.fromJson(Map<String, dynamic> json) => _$SetFiltersDtoFromJson(json);
}
