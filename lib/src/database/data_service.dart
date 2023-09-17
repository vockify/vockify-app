import 'package:drift/drift.dart';
import 'package:vockify/src/api/dto/sets/set_dto.dart';
import 'package:vockify/src/api/dto/sets/set_filters_dto.dart';
import 'package:vockify/src/api/dto/sets/set_terms_dto.dart';
import 'package:vockify/src/api/dto/terms/term_dto.dart';
import 'package:vockify/src/api/dto/terms/term_filters_dto.dart';
import 'package:vockify/src/database/database.dart';

late DataService dataService;

Future<void> setupDataService() async {
  dataService = DataService();
  // await dataService.database.deleteEverything();
  // await dataService.database.addDefaultSets();
}

class DataService {
  final database = AppDatabase();

  Future<List<SetDto>> getSets(SetFiltersDto filters) async {
    var categories = await database.select(database.categories).get();
    final terms = await database.select(database.terms).get();

    if (!filters.isCreatedByUser) {
      categories = categories.where((category) => !category.isDefault).toList();
    }

    if (filters.terms.isNotEmpty) {
      final matchedTerms = terms.where((term) => filters.terms.contains(term.name)).toList();
      final filteredCategoryIds = matchedTerms.fold(<int>[], (previousValue, element) {
        if (!previousValue.contains(element.setId)) {
          previousValue.add(element.setId);
        }

        return previousValue;
      });

      categories = categories.where((category) => filteredCategoryIds.contains(category.id)).toList();
    }

    return categories.map((category) {
      final setTerms = terms.where((term) => term.setId == category.id);
      final count = setTerms.length;

      return SetDto(
        id: category.id,
        name: category.name,
        parentId: category.parentId,
        icon: category.icon,
        terms: SetTermsDto(
          count: count,
        ),
        isDefault: category.isDefault,
      );
    }).toList();
  }

  Future<SetDto> copySet(int id) async {
    final category = await (database.select(database.categories)..where((c) => c.id.equals(id))).getSingle();
    final terms = await (database.select(database.terms)..where((t) => t.setId.equals(id))).get();

    await database.transaction(() async {
      final setId = await database.into(database.categories).insert(CategoriesCompanion(
            icon: Value(category.icon),
            name: Value(category.name),
            parentId: Value(category.parentId),
          ));

      await database.batch((batch) {
        batch.insertAll(
            database.terms,
            terms.map((term) => TermsCompanion.insert(
                  name: term.name,
                  definition: term.definition,
                  setId: setId,
                )));
      });
    });

    return SetDto(
      id: category.id,
      name: category.name,
      parentId: category.parentId,
      icon: category.icon,
      terms: SetTermsDto(
        count: terms.length,
      ),
      isDefault: category.isDefault,
    );
  }

  Future<List<TermDto>> getTerms(TermFiltersDto filters) async {
    final filteredTerms = database.select(database.terms);

    if (filters.setId != null) {
      filteredTerms.where((term) => term.setId.equals(filters.setId!));
    }

    return (await filteredTerms.get())
        .map((e) => TermDto(
              id: e.id,
              name: e.name,
              definition: e.definition,
              setId: e.setId,
              memorizationLevel: e.memorizationLevel,
            ))
        .toList();
  }

  Future<int> addSet(SetDto data) async {
    return database.into(database.categories).insert(data.toCompanion());
  }

  Future<int> addTerm(TermDto data) async {
    return database.into(database.terms).insert(data.toEntryInsert());
  }

  Future<int> deleteSet(int id) async {
    return (database.delete(database.categories)..where((c) => c.id.isValue(id))).go();
  }

  Future<int> deleteTerm(int id) async {
    return (database.delete(database.terms)..where((t) => t.id.isValue(id))).go();
  }

  Future<bool> updateSet(SetDto data) async {
    return database.update(database.categories).replace(data.toEntry());
  }

  Future<bool> updateTerm(TermDto data) async {
    final result =
        await (database.update(database.terms)..where((t) => t.id.isValue(data.id))).write(data.toEntryInsert());

    return result > 0;
  }
}
