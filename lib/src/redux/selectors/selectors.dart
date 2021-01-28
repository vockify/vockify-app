import 'package:reselect/reselect.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/feature_flag_state/feature_flag_state.dart';
import 'package:vockify/src/redux/state/history_data_state/history_data_state.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/redux/state/quiz_data_state/quiz_data_state.dart';
import 'package:vockify/src/redux/state/set_data_state/set_data_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';
import 'package:vockify/src/redux/state/term_data_state/term_data_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';
import 'package:vockify/src/redux/state/user_state/user_state.dart';

Selector<AppState, List<int>> getLastAddedTermIds = createSelector1(
  getHistoryDataState,
  (HistoryDataState state) => state.ids.toList(),
);

Selector<AppState, LoaderState> getLastTermLoader = createSelector1(
  getHistoryDataState,
  (HistoryDataState state) => state.loader,
);

Selector<AppState, List<int>> getPublicAndCurrentUserIds =
    createSelector1(getUserState, (UserState state) => [state.id, AppApi.publicUserId]);

Selector<AppState, List<int>> getPublicSetIds = createSelector1(
  getSetDataState,
  (SetDataState state) {
    final List<int> parentSetIds = state.items.values.map((set) => set.parentId).toList();

    return state.publicSetIds.where((set) => !parentSetIds.contains(set)).toList();
  },
);

Selector<AppState, LoaderState> getQuizLoader = createSelector1(
  getQuizDataState,
  (QuizDataState state) => state.loader,
);

Selector<AppState, List<int>> getQuizTermIds = createSelector1(
  getQuizDataState,
  (QuizDataState state) => state.ids.toList(),
);

Selector<AppState, Map<int, SetState>> getSetItems = createSelector1(
  getSetDataState,
  (SetDataState state) => state.items.toMap(),
);

Selector<AppState, LoaderState> getSetLoader = createSelector1(
  getSetDataState,
  (SetDataState state) => state.loader,
);

Selector<AppState, List<int>> getTermIds = createSelector1(
  getTermDataState,
  (TermDataState state) => state.ids.toList(),
);

Selector<AppState, Map<int, TermState>> getTermItems = createSelector1(
  getTermDataState,
  (TermDataState state) => state.items.toMap(),
);

Selector<AppState, LoaderState> getTermLoader = createSelector1(
  getTermDataState,
  (TermDataState state) => state.loader,
);

Selector<AppState, int> getUserId = createSelector1(getUserState, (UserState state) => state.id);

Selector<AppState, List<int>> getUserSetIds = createSelector1(
  getSetDataState,
  (SetDataState state) => state.userSetIds.toList(),
);

Selector<AppState, List<int>> getUserSetParentIds = createSelector2(
  getSetItems,
  getUserSetIds,
  (Map<int, SetState> items, List<int> ids) => ids.fold<List<int>>([], (result, id) {
    if (items[id].parentId != null) {
      result.add(items[id].parentId);
    }

    return result;
  }),
);

List<TermState> getLastAddedTerms(AppState state) {
  final items = getTermItems(state);
  final ids = getLastAddedTermIds(state);

  return ids.map((id) => items[id]).toList();
}

HistoryDataState getHistoryDataState(AppState state) => state.history;

QuizDataState getQuizDataState(AppState state) => state.quiz;

SetState getSetById(AppState state, int id) => getSetItems(state)[id];

SetDataState getSetDataState(AppState state) => state.sets;

TermState getTermById(AppState state, int id) => getTermItems(state)[id];

TermDataState getTermDataState(AppState state) => state.terms;

int getUserSetIdByParentId(AppState state, int parentId) {
  final items = getSetItems(state);
  final ids = getUserSetIds(state);

  return ids.firstWhere(
    (id) => items[id].parentId == parentId,
    orElse: () => null,
  );
}

UserState getUserState(AppState state) => state.user;

bool isAuthorized(AppState state) => state.isAuthorized;

bool isFeatureFlagEnabled(AppState state, FeatureFlag featureFlag) => state.featureFlags.items[featureFlag];

bool isLoading(AppState state) => state.isLoading;
