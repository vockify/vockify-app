import 'package:drift/drift.dart' as drift;
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vockify/src/database/database.dart' as db;
import 'package:vockify/src/models/memorization_level/memorization_level.dart';

part 'term_model.freezed.dart';
part 'term_model.g.dart';

@freezed
class TermModel with _$TermModel {
  const TermModel._();

  const factory TermModel({
    required int id,
    required int setId,
    required String name,
    required String definition,
    MemorizationLevel? memorizationLevel,
  }) = _TermModel;

  factory TermModel.fromJson(Map<String, Object?> json) =>
      _$TermModelFromJson(json);

  static TermModel fromEntry(db.Term term) {
    return TermModel(
      id: term.id,
      setId: term.setId,
      name: term.name,
      definition: term.definition,
      memorizationLevel: term.memorizationLevel != null ? MemorizationLevel(term.memorizationLevel!) : null,
    );
  }

  db.TermsCompanion toEntryUpdate() {
    return db.TermsCompanion(
      id: drift.Value(id),
      name: drift.Value(name),
      definition: drift.Value(definition),
      setId: drift.Value(setId),
    );
  }

  db.TermsCompanion toEntryInsert() {
    return db.TermsCompanion.insert(
      name: name,
      definition: definition,
      setId: setId,
      memorizationLevel: drift.Value(memorizationLevel.toString()),
    );
  }
}
