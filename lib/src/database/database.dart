import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 64)();
  TextColumn get icon => text().nullable()();
  IntColumn get parentId => integer().nullable()();
  BoolColumn get isDefault => boolean().withDefault(Constant(false))();
}

@DriftAccessor(tables: [Categories])
class CategoriesDao extends DatabaseAccessor<AppDatabase> with _$CategoriesDaoMixin {
  CategoriesDao(AppDatabase db) : super(db);
}

class Terms extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 64)();
  TextColumn get definition => text().withLength(min: 1, max: 64)();
  IntColumn get setId => integer()();
  TextColumn get memorizationLevel => text().nullable()();
}

@DriftAccessor(tables: [Terms])
class TermsDao extends DatabaseAccessor<AppDatabase> with _$TermsDaoMixin {
  TermsDao(AppDatabase db) : super(db);
}

@DriftDatabase(tables: [Categories, Terms], daos: [CategoriesDao, TermsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(categories, categories.isDefault);
        }
      },
    );
  }

  Future<void> deleteEverything() {
    return transaction(() async {
      await customStatement('PRAGMA foreign_keys = OFF');
      try {
        transaction(() async {
          for (final table in allTables) {
            await delete(table).go();
          }
        });
      } finally {
        await customStatement('PRAGMA foreign_keys = OFF');
      }
    });
  }

  Future<void> addDefaultSets() async {
    await transaction(() async {
      for (var i = 0; i < 3; i++) {
        final id = await into(categories).insert(CategoriesCompanion.insert(
          name: 'Default Set ${i + 1}',
          icon: Value(''),
          isDefault: Value(true),
        ));

        await batch((batch) {
          batch.insertAll(terms, [
            TermsCompanion.insert(
              name: 'name ${i + 1}',
              definition: 'definition ${i + 1}',
              setId: id,
            ),
            TermsCompanion.insert(
              name: 'name ${i + 2}',
              definition: 'definition ${i + 2}',
              setId: id,
            ),
            TermsCompanion.insert(
              name: 'name ${i + 3}',
              definition: 'definition ${i + 3}',
              setId: id,
            ),
            TermsCompanion.insert(
              name: 'name ${i + 4}',
              definition: 'definition ${i + 4}',
              setId: id,
            ),
          ]);
        });        
      }
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
