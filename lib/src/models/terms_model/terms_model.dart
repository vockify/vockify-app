import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vockify/src/database/database.dart' as db;
import 'package:vockify/src/models/term_model/term_model.dart';

part 'terms_model.freezed.dart';
part 'terms_model.g.dart';

@freezed
class TermsModel with _$TermsModel {
  const TermsModel._();

  const factory TermsModel({
    required List<int> ids,
    required Map<int, TermModel> terms,
  }) = _TermsModel;

  factory TermsModel.fromJson(Map<String, Object?> json) =>
      _$TermsModelFromJson(json);

  static TermsModel fromEntry(Iterable<db.Term> terms) {
    final termModels = terms.map((term) => TermModel.fromEntry(term)).toList();

    return TermsModel(
      ids: termModels.map((termModel) => termModel.id).toList(),
      terms: Map.fromEntries(
        termModels.map((termModel) => MapEntry(termModel.id, termModel)),
      ),
    );
  }
}
