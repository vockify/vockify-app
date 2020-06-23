import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

part 'term_data_state.g.dart';

abstract class TermDataState implements Built<TermDataState, TermDataStateBuilder> {
  factory TermDataState([void updates(TermDataStateBuilder b)]) = _$TermDataState;

  TermDataState._();

  @nullable
  TermState get added;

  BuiltList<int> get ids;

  LoaderState get loader;

  BuiltMap<int, TermState> get items;
}
