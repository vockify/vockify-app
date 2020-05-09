import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/api/dto/set_dto.dart';

part 'get_sets_response.g.dart';

@JsonSerializable(nullable: false)
class GetSetsResponse {
  final List<SetDto> data;

  GetSetsResponse(this.data);

  factory GetSetsResponse.fromJson(Map<String, dynamic> json) => _$GetSetsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetSetsResponseToJson(this);
}
