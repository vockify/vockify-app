import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';

part 'history_data_state.g.dart';

abstract class HistoryDataState implements Built<HistoryDataState, HistoryDataStateBuilder> {
  factory HistoryDataState([void updates(HistoryDataStateBuilder b)]) = _$HistoryDataState;

  factory HistoryDataState.initial() => HistoryDataState((builder) {
    builder
      ..ids.replace([])
      ..loader = LoaderState.isLoading;
  });

  HistoryDataState._();

  BuiltList<int> get ids;

  LoaderState get loader;
}
