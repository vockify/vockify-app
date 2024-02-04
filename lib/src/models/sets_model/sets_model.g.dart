// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sets_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SetsModelImpl _$$SetsModelImplFromJson(Map<String, dynamic> json) =>
    _$SetsModelImpl(
      ids: (json['ids'] as List<dynamic>).map((e) => e as int).toList(),
      sets: (json['sets'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            int.parse(k), SetModel.fromJson(e as Map<String, dynamic>)),
      ),
      isLoaded: json['isLoaded'] as bool,
    );

Map<String, dynamic> _$$SetsModelImplToJson(_$SetsModelImpl instance) =>
    <String, dynamic>{
      'ids': instance.ids,
      'sets': instance.sets.map((k, e) => MapEntry(k.toString(), e)),
      'isLoaded': instance.isLoaded,
    };
