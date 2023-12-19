// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TermsModelImpl _$$TermsModelImplFromJson(Map<String, dynamic> json) =>
    _$TermsModelImpl(
      ids: (json['ids'] as List<dynamic>).map((e) => e as int).toList(),
      terms: (json['terms'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            int.parse(k), TermModel.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$TermsModelImplToJson(_$TermsModelImpl instance) =>
    <String, dynamic>{
      'ids': instance.ids,
      'terms': instance.terms.map((k, e) => MapEntry(k.toString(), e)),
    };
