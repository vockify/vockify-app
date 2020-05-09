// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_sets_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSetsResponse _$GetSetsResponseFromJson(Map<String, dynamic> json) {
  return GetSetsResponse(
    (json['data'] as List)
        .map((e) => SetDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GetSetsResponseToJson(GetSetsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
