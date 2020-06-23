import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

part 'user_term_data_state.g.dart';

abstract class UserTermDataState implements Built<UserTermDataState, UserTermDataStateBuilder> {
  factory UserTermDataState([void updates(UserTermDataStateBuilder b)]) = _$UserTermDataState;

  factory UserTermDataState.initial() => UserTermDataState((builder) {
        builder
          ..ids.replace([])
          ..loader = LoaderState.isLoading;
      });

  UserTermDataState._();

  @nullable
  TermState get added;

  BuiltList<int> get ids;

  LoaderState get loader;
}
