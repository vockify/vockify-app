import 'package:reselect/reselect.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/redux/state/quiz_data_state/quiz_data_state.dart';
import 'package:vockify/src/redux/state/set_data_state/set_data_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';
import 'package:vockify/src/redux/state/term_data_state/public_term_data_state/public_term_data_state.dart';
import 'package:vockify/src/redux/state/term_data_state/term_data_state.dart';
import 'package:vockify/src/redux/state/term_data_state/user_term_data_state/user_term_data_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';
import 'package:vockify/src/redux/state/user_state/user_state.dart';

Selector<AppState, List<int>> getPublicSetIds = createSelector1(
  getSetDataState,
  (SetDataState state) {
    final List<int> parentSetIds  = state.items.values.map((set) => set.parentId).toList();

    return state.publicSetIds.where((set) => !parentSetIds.contains(set)).toList();
  },
);

Selector<AppState, PublicTermDataState> getPublicTermDataState = createSelector1(
  getTermDataState,
  (TermDataState state) => state.public,
);

Selector<AppState, List<int>> getPublicTermIds = createSelector1(
  getPublicTermDataState,
  (PublicTermDataState state) => state.ids.toList(),
);

Selector<AppState, LoaderState> getPublicTermLoader = createSelector1(
  getPublicTermDataState,
  (PublicTermDataState state) => state.loader,
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

Selector<AppState, Map<int, TermState>> getTermItems = createSelector1(
  getTermDataState,
  (TermDataState state) => state.items.toMap(),
);

Selector<AppState, List<int>> getUserSetIds = createSelector1(
  getSetDataState,
  (SetDataState state) => state.userSetIds.toList(),
);

Selector<AppState, LoaderState> getSetLoader = createSelector1(
  getSetDataState,
  (SetDataState state) => state.loader,
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

Selector<AppState, UserTermDataState> getUserTermDataState = createSelector1(
  getTermDataState,
  (TermDataState state) => state.user,
);

Selector<AppState, List<int>> getUserTermIds = createSelector1(
  getUserTermDataState,
  (UserTermDataState state) => state.ids.toList(),
);

Selector<AppState, LoaderState> getUserTermLoader = createSelector1(
  getUserTermDataState,
  (UserTermDataState state) => state.loader,
);

Selector<AppState, String> getLastAddedTerm = createSelector1(
  getTermDataState,
  (TermDataState state) => state.lastAddedTerm,
);

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

bool isLoading(AppState state) => state.isLoading;
