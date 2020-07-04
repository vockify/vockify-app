import 'package:built_value/built_value.dart';
import 'package:vockify/src/api/dto/sets/set_terms_memorization_dto.dart';

part 'set_terms_memorization_state.g.dart';

abstract class SetTermsMemorizationState implements Built<SetTermsMemorizationState, SetTermsMemorizationStateBuilder> {
  factory SetTermsMemorizationState([void updates(SetTermsMemorizationStateBuilder b)]) = _$SetTermsMemorizationState;

  factory SetTermsMemorizationState.fromDto(SetTermsMemorizationDto dto) => SetTermsMemorizationState((builder) {
        builder
          ..bad = dto.bad
          ..good = dto.good
          ..great = dto.great;
      });

  SetTermsMemorizationState._();

  int get bad;

  int get good;

  int get great;
}
