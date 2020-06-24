import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/term_data_state/public_term_data_state/public_term_data_state.dart';
import 'package:vockify/src/redux/state/term_data_state/user_term_data_state/user_term_data_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

part 'term_data_state.g.dart';

abstract class TermDataState implements Built<TermDataState, TermDataStateBuilder> {
  factory TermDataState([void updates(TermDataStateBuilder b)]) = _$TermDataState;

  factory TermDataState.initial() => TermDataState((builder) {
        builder
          ..items.replace({})
          ..public.replace(PublicTermDataState.initial())
          ..user.replace(UserTermDataState.initial());
      });

  TermDataState._();

  BuiltMap<int, TermState> get items;

  PublicTermDataState get public;

  UserTermDataState get user;
}
