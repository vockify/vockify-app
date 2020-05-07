import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';

part 'quiz_data_state.g.dart';

abstract class QuizDataState implements Built<QuizDataState, QuizDataStateBuilder> {
  factory QuizDataState([void updates(QuizDataStateBuilder b)]) = _$QuizDataState;

  factory QuizDataState.initial() => QuizDataState((builder) {
    builder
      ..ids.replace([])
      ..loader = LoaderState.isLoading;
  });

  QuizDataState._();

  BuiltList<int> get ids;

  LoaderState get loader;
}
