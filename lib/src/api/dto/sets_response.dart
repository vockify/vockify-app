import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/api/dto/set_dto.dart';

part 'sets_response.g.dart';

@JsonSerializable(nullable: false)
class SetsResponse {
  final List<SetDto> data;

  SetsResponse(this.data);

  factory SetsResponse.fromJson(Map<String, dynamic> json) => _$SetsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SetsResponseToJson(this);
}
