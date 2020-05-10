// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sets_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetsResponse _$SetsResponseFromJson(Map<String, dynamic> json) {
  return SetsResponse(
    (json['data'] as List)
        .map((e) => SetDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SetsResponseToJson(SetsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
