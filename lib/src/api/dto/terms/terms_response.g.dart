// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terms_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermsResponse _$TermsResponseFromJson(Map<String, dynamic> json) =>
    TermsResponse(
      (json['data'] as List<dynamic>)
          .map((e) => TermDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TermsResponseToJson(TermsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
