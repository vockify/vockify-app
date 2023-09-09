import 'package:vockify/src/redux/state/set_state/set_terms_memorization_state/set_terms_memorization_state.dart';

class SetTermsMemorizationDto {
  final int? bad;

  final int? good;

  final int? great;

  SetTermsMemorizationDto({this.bad, this.good, this.great});

  factory SetTermsMemorizationDto.fromState(SetTermsMemorizationState state) {
    return SetTermsMemorizationDto(
      bad: state.bad,
      good: state.good,
      great: state.great,
    );
  }
}
