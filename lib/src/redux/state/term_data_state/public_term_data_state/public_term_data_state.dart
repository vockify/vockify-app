import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';

part 'public_term_data_state.g.dart';

abstract class PublicTermDataState implements Built<PublicTermDataState, PublicTermDataStateBuilder> {
  factory PublicTermDataState([void updates(PublicTermDataStateBuilder b)]) = _$PublicTermDataState;

  factory PublicTermDataState.initial() => PublicTermDataState((builder) {
        builder
          ..ids.replace([])
          ..loader = LoaderState.isLoading;
      });

  PublicTermDataState._();

  BuiltList<int> get ids;

  LoaderState get loader;
}
