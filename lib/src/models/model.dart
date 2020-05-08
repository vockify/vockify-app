import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable(nullable: false)
class Model {
  final int page;

  Model(this.page);

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModelToJson(this);
}
