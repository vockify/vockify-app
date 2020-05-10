import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/api/dto/user_dto.dart';

part 'auth_user_response.g.dart';

@JsonSerializable(nullable: false)
class AuthUserResponse {
  final UserDto data;

  AuthUserResponse(this.data);

  factory AuthUserResponse.fromJson(Map<String, dynamic> json) => _$AuthUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserResponseToJson(this);
}
