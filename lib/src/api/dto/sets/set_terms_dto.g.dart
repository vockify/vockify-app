// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_terms_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetTermsDto _$SetTermsDtoFromJson(Map<String, dynamic> json) {
  return SetTermsDto(
    count: json['count'] as int ?? 0,
    memorization: SetTermsMemorizationDto.fromJson(
        json['memorization'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SetTermsDtoToJson(SetTermsDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'memorization': instance.memorization,
    };
