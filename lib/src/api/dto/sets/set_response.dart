import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/api/dto/sets/set_dto.dart';

part 'set_response.g.dart';

@JsonSerializable(nullable: false)
class SetResponse {
  final SetDto data;

  SetResponse(this.data);

  factory SetResponse.fromJson(Map<String, dynamic> json) => _$SetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SetResponseToJson(this);
}
