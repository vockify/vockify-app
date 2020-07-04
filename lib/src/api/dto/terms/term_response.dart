import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/api/dto/terms/term_dto.dart';

part 'term_response.g.dart';

@JsonSerializable(nullable: false)
class TermResponse {
  final TermDto data;

  TermResponse(this.data);

  factory TermResponse.fromJson(Map<String, dynamic> json) => _$TermResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TermResponseToJson(this);
}
