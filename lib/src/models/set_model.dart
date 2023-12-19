import 'package:drift/drift.dart';
import 'package:vockify/src/database/database.dart';
import 'package:vockify/src/models/term_model.dart';

class SetModel {
  final int id;

  final String name;

  final bool isDefault;

  final int? parentId;

  final String? icon;

  final List<TermModel> terms;

  SetModel({
    required this.id,
    required this.name,
    required this.isDefault,
    required this.terms,
    this.parentId,
    this.icon,
  });

  SetModel copyWith({
    int? id,
    String? name,
    bool? isDefault,
    List<TermModel>? terms,
    int? parentId,
    String? icon,
  }) {
    return SetModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      terms: terms ?? this.terms,
      parentId: parentId ?? this.parentId,
      icon: icon ?? this.icon,
    );
  }

  static SetModel fromData(Category category, Iterable<Term> terms) {
    return SetModel(
      id: category.id,
      name: category.name,
      isDefault: category.isDefault,
      terms: terms
          .map(
            (term) => TermModel(
              id: term.id,
              name: term.name,
              definition: term.definition,
              setId: term.setId,
            ),
          )
          .toList(),
      parentId: category.parentId,
      icon: category.icon,
    );
  }

  CategoriesCompanion toEntryUpdate() => CategoriesCompanion(
        id: Value(id),
        name: Value(name),
        icon: Value(icon),
        parentId: Value(parentId),
        isDefault: Value(isDefault),
      );

  CategoriesCompanion toEntryInsert() => CategoriesCompanion.insert(
        name: name,
        icon: Value(icon),
        parentId: Value(parentId),
        isDefault: Value(isDefault),
      );
}
