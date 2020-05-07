// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetResponse _$SetResponseFromJson(Map<String, dynamic> json) {
  return SetResponse(
    SetDto.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SetResponseToJson(SetResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
