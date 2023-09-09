import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'feature_flag_state.g.dart';

enum FeatureFlag {
  tour
}

abstract class FeatureFlagState implements Built<FeatureFlagState, FeatureFlagStateBuilder> {
  factory FeatureFlagState([void updates(FeatureFlagStateBuilder b)]) = _$FeatureFlagState;

  factory FeatureFlagState.initial() => FeatureFlagState((builder) {
    builder
      ..items.replace({
        FeatureFlag.tour: true,
      });
  });

  FeatureFlagState._();

  BuiltMap<FeatureFlag, bool> get items;
}
