import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/api/dto/sets/set_terms_dto.dart';
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

  @JsonKey(name: 'user_id')
  final int userId;

  final SetTermsDto terms;

  SetDto({
    @required this.id,
    @required this.name,
    this.parentId,
    this.icon,
    this.userId,
    this.terms,
  });

  factory SetDto.fromJson(Map<String, dynamic> json) => _$SetDtoFromJson(json);

  factory SetDto.fromState(SetState state) {
    return SetDto(
      id: state.id,
      name: state.name,
      parentId: state.parentId,
      userId: state.userId,
    );
  }

  Map<String, dynamic> toJson() => _$SetDtoToJson(this);
}
