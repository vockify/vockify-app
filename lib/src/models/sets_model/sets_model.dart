import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vockify/src/models/set_model/set_model.dart';

part 'sets_model.freezed.dart';
part 'sets_model.g.dart';

@freezed
class SetsModel with _$SetsModel {
  const factory SetsModel({
    required List<int> ids,
    required Map<int, SetModel> sets,
    required bool isLoaded,
  }) = _SetsModel;

  factory SetsModel.fromJson(Map<String, Object?> json) =>
      _$SetsModelFromJson(json);
}
