import 'package:reselect/reselect.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/quiz_data_state/quiz_data_state.dart';
import 'package:vockify/src/redux/state/set_data_state/public_set_data_state/public_set_data_state.dart';
import 'package:vockify/src/redux/state/set_data_state/set_data_state.dart';
import 'package:vockify/src/redux/state/set_data_state/user_set_data_state/user_set_data_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';
import 'package:vockify/src/redux/state/term_data_state/public_term_data_state/public_term_data_state.dart';
import 'package:vockify/src/redux/state/term_data_state/term_data_state.dart';
import 'package:vockify/src/redux/state/term_data_state/user_term_data_state/user_term_data_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';
import 'package:vockify/src/redux/state/user_state/user_state.dart';

Selector<AppState, SetState> getAddedUserSet =
    createSelector1(getUserSetDataState, (UserSetDataState state) => state.added);

Selector<AppState, TermState> getAddedUserTerm =
    createSelector1(getUserTermDataState, (UserTermDataState state) => state.added);

Selector<AppState, PublicSetDataState> getPublicSetDataState =
    createSelector1(getSetDataState, (SetDataState state) => state.public);

Selector<AppState, List<int>> getPublicSetIds =
    createSelector1(getPublicSetDataState, (PublicSetDataState state) => state.ids.toList());

Selector<AppState, PublicTermDataState> getPublicTermDataState =
    createSelector1(getTermDataState, (TermDataState state) => state.public);

Selector<AppState, List<int>> getPublicTermIds =
    createSelector1(getPublicTermDataState, (PublicTermDataState state) => state.ids.toList());

Selector<AppState, List<TermState>> getQuizTerms = createSelector1(
  getQuizDataState,
  (QuizDataState state) => state.items.toList(),
);

Selector<AppState, Map<int, SetState>> getSetItems =
    createSelector1(getSetDataState, (SetDataState state) => state.items.toMap());

Selector<AppState, Map<int, TermState>> getTermItems =
    createSelector1(getTermDataState, (TermDataState state) => state.items.toMap());

Selector<AppState, UserSetDataState> getUserSetDataState =
    createSelector1(getSetDataState, (SetDataState state) => state.user);

Selector<AppState, List<int>> getUserSetIds = createSelector1(
    getUserSetDataState,
    (UserSetDataState state) => [
          if (state.added != null) 0,
          ...state.ids,
        ]);

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

Selector<AppState, List<SetState>> getUserSets = createSelector3(
  getSetItems,
  getUserSetIds,
  getAddedUserSet,
  (Map<int, SetState> items, List<int> ids, SetState added) => [
    if (added != null) added,
    ...ids.map((id) => items[id]),
  ],
);

Selector<AppState, UserTermDataState> getUserTermDataState =
    createSelector1(getTermDataState, (TermDataState state) => state.user);

Selector<AppState, List<int>> getUserTermIds = createSelector1(
    getUserTermDataState,
    (UserTermDataState state) => [
          if (state.added != null) 0,
          ...state.ids,
        ]);

QuizDataState getQuizDataState(AppState state) => state.quiz;

SetState getSetById(AppState state, int id) {
  final added = getAddedUserSet(state);
  final items = getSetItems(state);

  if (id == 0) {
    return added;
  }

  return items[id];
}

SetDataState getSetDataState(AppState state) => state.sets;

TermState getTermById(AppState state, int id) {
  final added = getAddedUserTerm(state);
  final items = getTermItems(state);

  if (id == 0) {
    return added;
  }

  return items[id];
}

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
