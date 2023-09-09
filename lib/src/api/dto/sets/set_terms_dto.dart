import 'package:vockify/src/api/dto/sets/set_terms_memorization_dto.dart';
import 'package:vockify/src/redux/state/set_state/set_terms_state/set_terms_state.dart';

class SetTermsDto {
  final int? count;

  final SetTermsMemorizationDto? memorization;

  SetTermsDto({
    this.count,
    this.memorization,
  });

  factory SetTermsDto.fromState(SetTermsState state) {
    return SetTermsDto(
      count: state.count,
      memorization: state.memorization != null ? SetTermsMemorizationDto.fromState(state.memorization!) : null,
    );
  }
}
