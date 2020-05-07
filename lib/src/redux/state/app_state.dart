import 'package:built_value/built_value.dart';
import 'package:vockify/src/redux/state/feature_flag_state/feature_flag_state.dart';
import 'package:vockify/src/redux/state/history_data_state/history_data_state.dart';
import 'package:vockify/src/redux/state/quiz_data_state/quiz_data_state.dart';
import 'package:vockify/src/redux/state/set_data_state/set_data_state.dart';
import 'package:vockify/src/redux/state/term_data_state/term_data_state.dart';
import 'package:vockify/src/redux/state/user_state/user_state.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([void updates(AppStateBuilder b)]) = _$AppState;

  factory AppState.initial({String authToken, int selectedSetId}) => AppState((builder) {
        builder
          ..authToken = authToken
          ..isLoading = false
          ..featureFlags.replace(FeatureFlagState.initial())
          ..sets.replace(SetDataState.initial())
          ..terms.replace(TermDataState.initial())
          ..quiz.replace(QuizDataState.initial())
          ..history.replace(HistoryDataState.initial())
          ..user.replace(UserState.initial());
      });

  AppState._();

  @nullable
  String get currentRoute;

  FeatureFlagState get featureFlags;

  String get authToken;

  bool get isLoading;

  HistoryDataState get history;

  QuizDataState get quiz;

  SetDataState get sets;

  TermDataState get terms;

  UserState get user;
}
