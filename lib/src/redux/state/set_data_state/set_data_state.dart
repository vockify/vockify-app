import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

part 'set_data_state.g.dart';

abstract class SetDataState implements Built<SetDataState, SetDataStateBuilder> {
  factory SetDataState([void updates(SetDataStateBuilder b)]) = _$SetDataState;

  factory SetDataState.initial() => SetDataState((builder) {
        builder
          ..items.replace({})
          ..publicSetIds.replace([])
          ..userSetIds.replace([])
          ..loader = LoaderState.isLoading;
      });

  SetDataState._();

  BuiltMap<int, SetState> get items;

  LoaderState get loader;

  BuiltList<int> get publicSetIds;

  BuiltList<int> get userSetIds;
}
