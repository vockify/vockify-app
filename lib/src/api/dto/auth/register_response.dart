import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/api/dto/auth/register_dto.dart';

part 'register_response.g.dart';

@JsonSerializable(nullable: false)
class RegisterResponse {
  final RegisterDto data;

  RegisterResponse(this.data);

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
