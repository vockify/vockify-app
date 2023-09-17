// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DictionaryEntryDto _$DictionaryEntryDtoFromJson(Map<String, dynamic> json) =>
    DictionaryEntryDto(
      json['text'] as String?,
      json['pos'] as String?,
      json['ts'] as String?,
      (json['tr'] as List<dynamic>)
          .map((e) => TranslationDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
