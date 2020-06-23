import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

part 'public_set_data_state.g.dart';

abstract class PublicSetDataState implements Built<PublicSetDataState, PublicSetDataStateBuilder> {
  factory PublicSetDataState([void updates(PublicSetDataStateBuilder b)]) = _$PublicSetDataState;

  PublicSetDataState._();

  BuiltList<int> get ids;

  bool get isLoaded;

  BuiltMap<int, SetState> get items;
}
