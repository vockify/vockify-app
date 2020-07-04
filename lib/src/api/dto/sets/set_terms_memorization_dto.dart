import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/redux/state/set_state/set_terms_memorization_state/set_terms_memorization_state.dart';

part 'set_terms_memorization_dto.g.dart';

@JsonSerializable(nullable: false)
class SetTermsMemorizationDto {
  @JsonKey(nullable: true, defaultValue: 0)
  final int bad;

  @JsonKey(nullable: true, defaultValue: 0)
  final int good;

  @JsonKey(nullable: true, defaultValue: 0)
  final int great;

  SetTermsMemorizationDto({this.bad, this.good, this.great});

  factory SetTermsMemorizationDto.fromJson(Map<String, dynamic> json) => _$SetTermsMemorizationDtoFromJson(json);

  factory SetTermsMemorizationDto.fromState(SetTermsMemorizationState state) {
    return SetTermsMemorizationDto(
      bad: state.bad,
      good: state.good,
      great: state.great,
    );
  }

  Map<String, dynamic> toJson() => _$SetTermsMemorizationDtoToJson(this);
}
