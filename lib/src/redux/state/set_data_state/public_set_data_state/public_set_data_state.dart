import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';

part 'public_set_data_state.g.dart';

abstract class PublicSetDataState implements Built<PublicSetDataState, PublicSetDataStateBuilder> {
  factory PublicSetDataState([void updates(PublicSetDataStateBuilder b)]) = _$PublicSetDataState;

  factory PublicSetDataState.initial() => PublicSetDataState((builder) {
        builder
          ..ids.replace([])
          ..loader = LoaderState.isLoading;
      });

  PublicSetDataState._();

  BuiltList<int> get ids;

  LoaderState get loader;
}
