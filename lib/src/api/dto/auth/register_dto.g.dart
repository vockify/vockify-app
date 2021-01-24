// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterDto _$RegisterDtoFromJson(Map<String, dynamic> json) {
  return RegisterDto(
    UserDto.fromJson(json['user'] as Map<String, dynamic>),
    TokenDto.fromJson(json['token'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RegisterDtoToJson(RegisterDto instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };
