import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

part 'set_dto.g.dart';

@JsonSerializable(nullable: false)
class SetDto {
  final int id;

  final String name;

  @JsonKey(nullable: true)
  final String icon;

  @JsonKey(name: 'parent_set_id', nullable: true)
  final int parentId;

  @JsonKey(name: 'terms_count', nullable: true, defaultValue: 0)
  final int termsCount;

  SetDto({
    @required this.id,
    @required this.name,
    this.parentId,
    this.icon,
    this.termsCount,
  });

  factory SetDto.fromJson(Map<String, dynamic> json) => _$SetDtoFromJson(json);

  factory SetDto.fromState(SetState state) {
    return SetDto(id: state.id, name: state.name, parentId: state.parentId);
  }

  Map<String, dynamic> toJson() => _$SetDtoToJson(this);
}
