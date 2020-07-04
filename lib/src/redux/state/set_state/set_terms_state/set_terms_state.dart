import 'package:built_value/built_value.dart';
import 'package:vockify/src/api/dto/sets/set_terms_dto.dart';
import 'package:vockify/src/redux/state/set_state/set_terms_memorization_state/set_terms_memorization_state.dart';

part 'set_terms_state.g.dart';

abstract class SetTermsState implements Built<SetTermsState, SetTermsStateBuilder> {
  factory SetTermsState([void updates(SetTermsStateBuilder b)]) = _$SetTermsState;

  factory SetTermsState.fromDto(SetTermsDto dto) => SetTermsState((builder) {
        builder
          ..count = dto.count
          ..memorization.replace(SetTermsMemorizationState.fromDto(dto.memorization));
      });

  SetTermsState._();

  int get count;

  SetTermsMemorizationState get memorization;
}
