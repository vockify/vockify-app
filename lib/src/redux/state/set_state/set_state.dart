import 'package:built_value/built_value.dart';
import 'package:vockify/src/api/dto/set_dto.dart';

part 'set_state.g.dart';

abstract class SetState implements Built<SetState, SetStateBuilder> {
  factory SetState([void updates(SetStateBuilder b)]) = _$SetState;

  factory SetState.fromDto(SetDto dto) => SetState((builder) {
        builder
          ..icon = dto.icon
          ..name = dto.name
          ..id = dto.id
          ..parentId = dto.parentId
          ..termsCount = dto.termsCount;
      });

  SetState._();

  @nullable
  String get icon;

  int get id;

  String get name;

  @nullable
  int get parentId;

  int get termsCount;
}
