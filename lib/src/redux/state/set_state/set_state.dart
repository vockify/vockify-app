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
          ..terms.replace(SetTermsState.fromDto(dto.terms));
      });

  SetState._();

  @nullable
  String get icon;

  int get id;

  String get name;

  @nullable
  int get parentId;

  SetTermsState get terms;
}
