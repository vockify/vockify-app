// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslateResponse _$TranslateResponseFromJson(Map<String, dynamic> json) =>
    TranslateResponse(
      (json['def'] as List<dynamic>)
          .map((e) => DictionaryEntryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
