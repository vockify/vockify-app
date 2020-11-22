import 'package:json_annotation/json_annotation.dart';

part 'set_filters_dto.g.dart';

@JsonSerializable(nullable: false)
class SetFiltersDto {
  final List<int> userIds;

  SetFiltersDto({
    this.userIds
  });

  factory SetFiltersDto.fromJson(Map<String, dynamic> json) => _$SetFiltersDtoFromJson(json);

  Map<String, String> toJson() => {
    'filter[user_id]': userIds.join(','),
  };
}
