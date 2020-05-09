import 'package:json_annotation/json_annotation.dart';

part 'set_dto.g.dart';

@JsonSerializable(nullable: false)
class SetDto {
  final int id;
  final String name;
  final String icon;

  SetDto(this.id, this.name, this.icon);

  factory SetDto.fromJson(Map<String, dynamic> json) => _$SetDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SetDtoToJson(this);
}
