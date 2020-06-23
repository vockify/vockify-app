import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

part 'set_dto.g.dart';

@JsonSerializable(nullable: false)
class SetDto {
  final int id;

  final String name;

  final String icon;

  @JsonKey(name: 'terms_count', nullable: true, defaultValue: 0)
  final int termsCount;

  SetDto(this.id, this.name, [this.icon, this.termsCount]);

  factory SetDto.fromJson(Map<String, dynamic> json) => _$SetDtoFromJson(json);

  factory SetDto.fromState(SetState state) {
    return SetDto(state.id, state.name);
  }

  Map<String, dynamic> toJson() => _$SetDtoToJson(this);
}
