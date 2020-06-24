import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

List<int> getPublicSetIds(AppState state) {
  return state.sets.public.ids.toList();
}

List<SetState> getPublicSets(AppState state) {
  final ids = state.sets.public.ids;
  final items = state.sets.items;

  return ids.map((id) => items[id]).toList();
}

List<int> getPublicTermIds(AppState state) {
  return state.terms.public.ids.toList();
}

List<TermState> getPublicTerms(AppState state) {
  final ids = state.terms.public.ids;
  final items = state.terms.items;

  return ids.map((id) => items[id]).toList();
}

SetState getSetById(AppState state, int id) {
  final added = state.sets.user.added;
  final items = state.sets.items;

  if (id == 0) {
    return added;
  }

  return items[id];
}

TermState getTermById(AppState state, int id) {
  final added = state.terms.user.added;
  final items = state.terms.items;

  if (id == 0) {
    return added;
  }

  return items[id];
}

int getUserSetIdByParentId(AppState state, int parentId) {
  final items = state.sets.items;
  return state.sets.user.ids.firstWhere((id) => items[id].parentId == parentId, orElse: () => null);
}

List<int> getUserSetIds(AppState state) {
  final added = state.sets.user.added;
  final ids = state.sets.user.ids;

  return [
    if (added != null) 0,
    ...ids,
  ];
}

List<int> getUserSetParentIds(AppState state) {
  final items = state.sets.items;
  final ids = state.sets.user.ids.fold<List<int>>([], (result, id) {
    if (items[id].parentId != null) {
      result.add(items[id].parentId);
    }

    return result;
  });

  return ids;
}

List<SetState> getUserSets(AppState state) {
  final added = state.sets.user.added;
  final ids = state.sets.user.ids;
  final items = state.sets.items;

  return [
    if (added != null) added,
    ...ids.map((id) => items[id]),
  ];
}

List<int> getUserTermIds(AppState state) {
  final added = state.terms.user.added;
  final ids = state.terms.user.ids;

  return [
    if (added != null) 0,
    ...ids,
  ];
}

List<TermState> getUserTerms(AppState state) {
  final added = state.terms.user.added;
  final ids = state.terms.user.ids;
  final items = state.terms.items;

  return [
    if (added != null) added,
    ...ids.map((id) => items[id]),
  ];
}

bool isLoading(AppState state, String key) => state.isLoading;

bool isSetCopied(AppState state, int id) {
  final ids = getUserSetParentIds(state);
  return ids.contains(id);
}
