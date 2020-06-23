import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

List<SetState> getPublicSets(AppState state) {
  final ids = state.sets.public.ids;
  final items = state.sets.public.items;

  return ids.map((id) => items[id]).toList();
}

List<TermState> getTerms(AppState state) {
  final added = state.terms.added;
  final ids = state.terms.ids;
  final items = state.terms.items;

  return [
    if (added != null) added,
    ...ids.map((id) => items[id]),
  ];
}

List<SetState> getUserSets(AppState state) {
  final added = state.sets.user.added;
  final ids = state.sets.user.ids;
  final items = state.sets.user.items;

  return [
    if (added != null) added,
    ...ids.map((id) => items[id]),
  ];
}

bool isLoading(AppState state, String key) => state.loading[key] ?? false;
