import 'package:json_annotation/json_annotation.dart';

part 'token_dto.g.dart';

@JsonSerializable(nullable: false)
class TokenDto {
  final String plainTextToken;

  TokenDto(this.plainTextToken);

  factory TokenDto.fromJson(Map<String, dynamic> json) => _$TokenDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TokenDtoToJson(this);
}
