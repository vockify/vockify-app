import 'package:drift/drift.dart';
import 'package:vockify/src/database/database.dart';
import 'package:vockify/src/models/set_model/set_model.dart';
import 'package:vockify/src/models/term_model/term_model.dart';

late DataRepository dataRepository;

Future<void> setupDataService() async {
  dataRepository = DataRepository();
  // await dataService.database.deleteEverything();
  // await dataService.database.addDefaultSets();
}

class DataRepository {
  final database = AppDatabase();

  Future<SetModel> getSet(int id) async {
    final terms = await database.select(database.terms).get();
    final categories = await database.select(database.categories).get();

    final category = categories.firstWhere((category) => category.id == id);
    final setTerms = terms.where((term) => term.setId == category.id);

    return SetModel.fromEntry(category, setTerms);
  }

  Future<List<SetModel>> getSets({
    bool? isCreatedByUser,
  }) async {
    var categories = await database.select(database.categories).get();
    final terms = await database.select(database.terms).get();

    if (isCreatedByUser != null) {
      categories = categories.where((category) => !category.isDefault).toList();
    }

    // if (filters.terms.isNotEmpty) {
    //   final matchedTerms =
    //       terms.where((term) => filters.terms.contains(term.name)).toList();
    //   final filteredCategoryIds =
    //       matchedTerms.fold(<int>[], (previousValue, element) {
    //     if (!previousValue.contains(element.setId)) {
    //       previousValue.add(element.setId);
    //     }

    //     return previousValue;
    //   });

    //   categories = categories
    //       .where((category) => filteredCategoryIds.contains(category.id))
    //       .toList();
    // }

    return categories.map((category) {
      final setTerms = terms.where((term) => term.setId == category.id);
      return SetModel.fromEntry(category, setTerms);
    }).toList();
  }

  Future<SetModel> copySet(int id) async {
    final category = await (database.select(database.categories)
          ..where((c) => c.id.equals(id)))
        .getSingle();

    final terms = await (database.select(database.terms)
          ..where((t) => t.setId.equals(id)))
        .get();

    final categoryCopy = await database.transaction<Category>(() async {
      final categoryId = await database.into(database.categories).insert(
            CategoriesCompanion(
              icon: Value(category.icon),
              name: Value(category.name),
              parentId: Value(category.id),
            ),
          );

      await database.batch(
        (batch) {
          batch.insertAll(
            database.terms,
            terms.map(
              (term) => TermsCompanion.insert(
                name: term.name,
                definition: term.definition,
                setId: categoryId,
              ),
            ),
          );
        },
      );

      return await (database.select(database.categories)
            ..where((c) => c.id.equals(categoryId)))
          .getSingle();
    });

    final termCopies = await (database.select(database.terms)
          ..where((t) => t.setId.equals(categoryCopy.id)))
        .get();

    return SetModel.fromEntry(categoryCopy, termCopies);
  }

  Future<List<TermModel>> getLastAddedTerms() async {
    final terms = database.select(database.terms);
    terms.limit(10);

    return (await terms.get())
        .map((term) => TermModel.fromEntry(term))
        .toList();
  }

  Future<List<TermModel>> getTerms({int? setId}) async {
    final filteredTerms = database.select(database.terms);

    if (setId != null) {
      filteredTerms.where((term) => term.setId.equals(setId));
    }

    final terms = (await filteredTerms.get());

    terms.map((term) => TermModel.fromJson(term.toJson()));

    return (await filteredTerms.get())
        .map((term) => TermModel.fromEntry(term))
        .toList();
  }

  Future<int> addSet(SetModel set) async {
    return database.into(database.categories).insert(set.toEntryInsert());
  }

  Future<int> addTerm(TermModel term) async {
    return database.into(database.terms).insert(term.toEntryInsert());
  }

  Future<int> deleteSet(int id) async {
    return (database.delete(database.categories)
          ..where((c) => c.id.isValue(id)))
        .go();
  }

  Future<int> deleteTerm(int id) async {
    return (database.delete(database.terms)..where((t) => t.id.isValue(id)))
        .go();
  }

  Future<bool> updateSet(SetModel set) async {
    return database.update(database.categories).replace(set.toEntryUpdate());
  }

  Future<bool> updateTerm(TermModel term) async {
    return database.update(database.terms).replace(term.toEntryUpdate());
  }
}
