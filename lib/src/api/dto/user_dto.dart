import 'package:built_value/built_value.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable(nullable: false)
class UserDto {
  final int id;

  final String email;

  @JsonKey(name: 'first_name')
  @nullable
  final String firstName;

  @JsonKey(name: 'last_name')
  @nullable
  final String lastName;

  @nullable
  final String avatar;

  @JsonKey(name: 'is_registered')
  final bool isRegistered;

  UserDto(this.id, this.email, this.firstName, this.lastName, this.avatar, this.isRegistered);

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
