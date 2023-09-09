import 'package:built_value/built_value.dart';
import 'package:vockify/src/api/dto/sets/set_dto.dart';
import 'package:vockify/src/redux/state/set_state/set_terms_state/set_terms_state.dart';

part 'set_state.g.dart';

abstract class SetState implements Built<SetState, SetStateBuilder> {
  factory SetState([void updates(SetStateBuilder b)]) = _$SetState;

  factory SetState.fromDto(SetDto dto) => SetState((builder) {
        builder
          ..icon = dto.icon
          ..name = dto.name
          ..id = dto.id
          ..parentId = dto.parentId
          ..isDefault = dto.isDefault;

        final terms = dto.terms;
        if (terms != null) {
          builder.terms.replace(SetTermsState.fromDto(terms));
        }
      });

  SetState._();

  String? get icon;

  int get id;

  String get name;

  int? get parentId;

  SetTermsState get terms;

  bool get isDefault;
}
