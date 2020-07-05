import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/set_data_state/public_set_data_state/public_set_data_state.dart';
import 'package:vockify/src/redux/state/set_data_state/user_set_data_state/user_set_data_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

part 'set_data_state.g.dart';

abstract class SetDataState implements Built<SetDataState, SetDataStateBuilder> {
  factory SetDataState([void updates(SetDataStateBuilder b)]) = _$SetDataState;

  factory SetDataState.initial() => SetDataState((builder) {
        builder
          ..items.replace({})
          ..public.replace(PublicSetDataState.initial())
          ..user.replace(UserSetDataState.initial());
      });

  SetDataState._();

  BuiltMap<int, SetState> get items;

  PublicSetDataState get public;

  UserSetDataState get user;
}
