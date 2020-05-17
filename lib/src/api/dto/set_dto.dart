import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/redux/state/set_state.dart';

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

  Map<String, dynamic> toJson() => _$SetDtoToJson(this);

  SetState toState() => SetState((builder) {
        builder
          ..icon = icon
          ..name = name
          ..id = id
          ..termsCount = termsCount;
      });
}
