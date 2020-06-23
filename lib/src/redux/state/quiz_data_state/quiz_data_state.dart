import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

part 'quiz_data_state.g.dart';

abstract class QuizDataState implements Built<QuizDataState, QuizDataStateBuilder> {
  factory QuizDataState([void updates(QuizDataStateBuilder b)]) = _$QuizDataState;

  factory QuizDataState.initial() => QuizDataState((builder) {
    builder
      ..items.replace({})
      ..loader = LoaderState.isLoading;
  });

  QuizDataState._();

  BuiltList<TermState> get items;

  LoaderState get loader;
}
