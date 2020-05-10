import 'package:built_value/built_value.dart';
import 'package:vockify/src/api/dto/sets_response.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([void updates(AppStateBuilder b)]) = _$AppState;

  AppState._();

  bool get isAuthorized;

  SetsResponse get sets;
}
