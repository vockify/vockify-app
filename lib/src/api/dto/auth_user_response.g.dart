// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUserResponse _$AuthUserResponseFromJson(Map<String, dynamic> json) {
  return AuthUserResponse(
    UserDto.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuthUserResponseToJson(AuthUserResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
