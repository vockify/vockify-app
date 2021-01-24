import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/api/dto/user_dto.dart';

part 'user_response.g.dart';

@JsonSerializable(nullable: false)
class UserResponse {
  final UserDto data;

  UserResponse(this.data);

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
