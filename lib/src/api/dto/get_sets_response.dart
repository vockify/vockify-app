import 'package:json_annotation/json_annotation.dart';

part 'get_sets_response.g.dart';

@JsonSerializable(nullable: false)
class GetSetsResponse {
  final int page;

  GetSetsResponse(this.page);

  factory GetSetsResponse.fromJson(Map<String, dynamic> json) => _$GetSetsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetSetsResponseToJson(this);
}
