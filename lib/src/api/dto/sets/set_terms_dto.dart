import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/api/dto/sets/set_terms_memorization_dto.dart';
import 'package:vockify/src/redux/state/set_state/set_terms_state/set_terms_state.dart';

part 'set_terms_dto.g.dart';

@JsonSerializable()
class SetTermsDto {
  @JsonKey(defaultValue: 0)
  final int? count;

  final SetTermsMemorizationDto? memorization;

  SetTermsDto({
    this.count,
    this.memorization,
  });

  factory SetTermsDto.fromJson(Map<String, dynamic> json) => _$SetTermsDtoFromJson(json);

  factory SetTermsDto.fromState(SetTermsState state) {
    return SetTermsDto(
      count: state.count,
      memorization: SetTermsMemorizationDto.fromState(state.memorization),
    );
  }

  Map<String, dynamic> toJson() => _$SetTermsDtoToJson(this);
}
