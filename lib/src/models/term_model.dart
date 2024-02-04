import 'package:drift/drift.dart';
import 'package:vockify/src/database/database.dart';

class TermModel {
  final int id;

  final String name;

  final String definition;

  final int setId;

  final String? memorizationLevel;

  TermModel({
    required this.id,
    required this.name,
    required this.definition,
    required this.setId,
    this.memorizationLevel,
  });

  TermModel copyWith({
    int? id,
    String? name,
    String? definition,
    int? setId,
    String? memorizationLevel,
  }) =>
      TermModel(
        id: id ?? this.id,
        name: name ?? this.name,
        definition: definition ?? this.definition,
        setId: setId ?? this.setId,
        memorizationLevel: memorizationLevel ?? this.memorizationLevel,
      );

  static TermModel fromData(Term term) => TermModel(
        id: term.id,
        setId: term.setId,
        name: term.name,
        definition: term.definition,
        memorizationLevel: term.memorizationLevel,
      );

  TermsCompanion toEntryUpdate() => TermsCompanion(
        id: Value(id),
        name: Value(name),
        definition: Value(definition),
        setId: Value(setId),
        memorizationLevel: Value(memorizationLevel),
      );

  TermsCompanion toEntryInsert() => TermsCompanion.insert(
        name: name,
        definition: definition,
        setId: setId,
        memorizationLevel: Value(memorizationLevel),
      );
}
