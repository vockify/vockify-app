import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';

part 'last_term_data_state.g.dart';

abstract class LastTermDataState implements Built<LastTermDataState, LastTermDataStateBuilder> {
  factory LastTermDataState([void updates(LastTermDataStateBuilder b)]) = _$LastTermDataState;

  factory LastTermDataState.initial() => LastTermDataState((builder) {
    builder
      ..ids.replace([])
      ..loader = LoaderState.isLoading;
  });

  LastTermDataState._();

  BuiltList<int> get ids;

  LoaderState get loader;
}
