import 'package:built_collection/built_collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vockify/src/api/dto/set_dto.dart';
import 'package:vockify/src/redux/state/set_state.dart';

part 'sets_response.g.dart';

@JsonSerializable(nullable: false)
class SetsResponse {
  final List<SetDto> data;

  SetsResponse(this.data);

  factory SetsResponse.fromJson(Map<String, dynamic> json) =>
      _$SetsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SetsResponseToJson(this);

  BuiltList<SetState> toState() => BuiltList(data.map((e) => e.toState()));
}
