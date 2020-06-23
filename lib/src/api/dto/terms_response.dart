import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/api/dto/term_dto.dart';

part 'terms_response.g.dart';

@JsonSerializable(nullable: false)
class TermsResponse {
  final List<TermDto> data;

  TermsResponse(this.data);

  factory TermsResponse.fromJson(Map<String, dynamic> json) => _$TermsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TermsResponseToJson(this);
}
