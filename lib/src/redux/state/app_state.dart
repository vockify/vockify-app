import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/set_state.dart';
import 'package:vockify/src/redux/state/term_state.dart';
import 'package:vockify/src/redux/state/user_state.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([void updates(AppStateBuilder b)]) = _$AppState;

  AppState._();

  @nullable
  String get currentRoute;

  bool get isAuthorized;

  @nullable
  int get selectedSetId;

  @nullable
  String get translatedDefinition;

  bool get isLoading;

  BuiltList<SetState> get sets;

  BuiltList<TermState> get terms;

  UserState get user;
}
