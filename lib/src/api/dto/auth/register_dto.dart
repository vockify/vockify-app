import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/api/dto/auth/token_dto.dart';
import 'package:vockify/src/api/dto/user_dto.dart';

part 'register_dto.g.dart';

@JsonSerializable(nullable: false)
class RegisterDto {
  final UserDto user;

  final TokenDto token;

  RegisterDto(this.user, this.token);

  factory RegisterDto.fromJson(Map<String, dynamic> json) => _$RegisterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);
}
