import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/quiz_data_state/quiz_data_state.dart';
import 'package:vockify/src/redux/state/set_data_state/set_data_state.dart';
import 'package:vockify/src/redux/state/term_data_state/term_data_state.dart';
import 'package:vockify/src/redux/state/user_state/user_state.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([void updates(AppStateBuilder b)]) = _$AppState;

  factory AppState.initial({bool isAuthorized, int selectedSetId}) => AppState((builder) {
        builder
          ..isAuthorized = isAuthorized ?? false
          ..isLoading = true
          ..sets.replace(SetDataState.initial())
          ..terms.replace(TermDataState.initial())
          ..quiz.replace(QuizDataState.initial())
          ..user.replace(UserState.initial(selectedSetId: selectedSetId));
      });

  AppState._();

  @nullable
  String get currentRoute;

  bool get isAuthorized;

  bool get isLoading;

  SetDataState get sets;

  TermDataState get terms;

  QuizDataState get quiz;

  UserState get user;
}
