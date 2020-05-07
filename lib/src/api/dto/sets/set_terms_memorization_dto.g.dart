// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_terms_memorization_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetTermsMemorizationDto _$SetTermsMemorizationDtoFromJson(
    Map<String, dynamic> json) {
  return SetTermsMemorizationDto(
    bad: json['bad'] as int ?? 0,
    good: json['good'] as int ?? 0,
    great: json['great'] as int ?? 0,
  );
}

Map<String, dynamic> _$SetTermsMemorizationDtoToJson(
        SetTermsMemorizationDto instance) =>
    <String, dynamic>{
      'bad': instance.bad,
      'good': instance.good,
      'great': instance.great,
    };
