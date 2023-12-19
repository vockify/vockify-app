import 'package:drift/drift.dart' as drift;
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vockify/src/database/database.dart' as db;
import 'package:vockify/src/models/terms_model/terms_model.dart';

part 'set_model.freezed.dart';
part 'set_model.g.dart';

@freezed
class SetModel with _$SetModel {
  const SetModel._();

  const factory SetModel({
    required int id,
    required String name,
    required bool isDefault,
    required TermsModel terms,
    int? parentId,
    String? icon,
  }) = _SetModel;

  factory SetModel.fromJson(Map<String, Object?> json) =>
      _$SetModelFromJson(json);

  static SetModel fromEntry(db.Category category, Iterable<db.Term> terms) {
    return SetModel(
      id: category.id,
      name: category.name,
      isDefault: category.isDefault,
      terms: TermsModel.fromEntry(terms),
      parentId: category.parentId,
      icon: category.icon,
    );
  }

  db.CategoriesCompanion toEntryUpdate() {
    return db.CategoriesCompanion(
      id: drift.Value(id),
      name: drift.Value(name),
      icon: drift.Value(icon),
      parentId: drift.Value(parentId),
      isDefault: drift.Value(isDefault),
    );
  }

  db.CategoriesCompanion toEntryInsert() {
    return db.CategoriesCompanion.insert(
      name: name,
      icon: drift.Value(icon),
      parentId: drift.Value(parentId),
      isDefault: drift.Value(isDefault),
    );
  }
}
