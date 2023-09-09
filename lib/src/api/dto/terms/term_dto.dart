import 'package:drift/drift.dart';
import 'package:vockify/src/database/database.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class TermDto {
  final int id;

  final String name;

  final String definition;

  final int setId;

  final String? memorizationLevel;

  TermDto({
    required this.id,
    required this.name,
    required this.setId,
    required this.definition,
    this.memorizationLevel,
  });

  factory TermDto.fromState(TermState state) {
    return TermDto(
      id: state.id,
      name: state.name,
      definition: state.definition,
      setId: state.setId,
      memorizationLevel: state.memorizationLevel?.toString(),
    );
  }

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
  );
}
