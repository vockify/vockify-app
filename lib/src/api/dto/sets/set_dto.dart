import 'package:drift/drift.dart';
import 'package:vockify/src/api/dto/sets/set_terms_dto.dart';
import 'package:vockify/src/database/database.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

class SetDto {
  final int id;

  final String name;

  final String? icon;

  final int? parentId;

  final SetTermsDto? terms;

  final bool isDefault;

  SetDto({
    required this.id,
    required this.name,
    required this.isDefault,
    this.parentId,
    this.icon,
    this.terms,
  });

  factory SetDto.fromState(SetState state) {
    return SetDto(
      id: state.id,
      isDefault: state.isDefault,
      name: state.name,
      parentId: state.parentId,
    );
  }

  Category toEntry() => Category(
        id: id,
        name: name,
        icon: icon,
        parentId: parentId,
        isDefault: isDefault,
      );

  CategoriesCompanion toCompanion() => CategoriesCompanion(
    name: Value(name),
    icon: Value(icon),
    parentId: Value(parentId),
    isDefault: Value(isDefault),
  );
}
