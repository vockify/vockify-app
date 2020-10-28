import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

part 'term_data_state.g.dart';

abstract class TermDataState implements Built<TermDataState, TermDataStateBuilder> {
  factory TermDataState([void updates(TermDataStateBuilder b)]) = _$TermDataState;

  factory TermDataState.initial() => TermDataState((builder) {
        builder
          ..lastAddedTerm = ''
          ..items.replace({})
          ..ids.replace([])
          ..loader = LoaderState.isLoading;
      });

  TermDataState._();

  BuiltList<int> get ids;

  BuiltMap<int, TermState> get items;

  String get lastAddedTerm;

  LoaderState get loader;
}
