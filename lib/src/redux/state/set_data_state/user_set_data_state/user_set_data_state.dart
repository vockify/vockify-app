import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

part 'user_set_data_state.g.dart';

abstract class UserSetDataState implements Built<UserSetDataState, UserSetDataStateBuilder> {
  factory UserSetDataState([void updates(UserSetDataStateBuilder b)]) = _$UserSetDataState;

  factory UserSetDataState.initial() => UserSetDataState((builder) {
        builder
          ..ids.replace([])
          ..loader = LoaderState.isLoading;
      });

  UserSetDataState._();

  BuiltList<int> get ids;

  LoaderState get loader;
}
