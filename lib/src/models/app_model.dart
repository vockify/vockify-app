import 'package:flutter/material.dart';
import 'package:vockify/src/models/set_model/set_model.dart';
import 'package:vockify/src/models/sets_model/sets_model.dart';
import 'package:vockify/src/models/term_model/term_model.dart';
import 'package:vockify/src/services/data_repository/data_repository.dart';

class AppModel extends ChangeNotifier {
  SetsModel state = SetsModel(ids: [], sets: {}, isLoaded: false);

  List<TermModel> lastAddedTerms = [];

  Future<void> init() async {
    final sets = await dataRepository.getSets();
    final lastAddedTerms = await dataRepository.getLastAddedTerms();

    state = SetsModel(
      ids: sets.map((set) => set.id).toList(),
      sets: Map.fromEntries(sets.map((set) => MapEntry(set.id, set))),
      isLoaded: true,
    );

    this.lastAddedTerms = lastAddedTerms;

    notifyListeners();
  }

  Future<void> addSet(SetModel set) async {
    final id = await dataRepository.addSet(set);

    state = state.copyWith(
      ids: [...state.ids, id],
      sets: {...state.sets, id: set.copyWith(id: id)},
    );

    notifyListeners();
  }

  Future<void> addTerm(int setId, TermModel term) async {
    final id = await dataRepository.addTerm(term);

    final set = state.sets[setId]!;

    state = state.copyWith(
      sets: {
        ...state.sets,
        id: set.copyWith(
          terms: set.terms.copyWith(
            ids: [...set.terms.ids, id],
            terms: {...set.terms.terms, id: term.copyWith(id: id)},
          ),
        )
      },
    );

    lastAddedTerms = [...lastAddedTerms, term];

    notifyListeners();
  }

  void updateSet(SetModel set) async {
    dataRepository.updateSet(set);

    state = state.copyWith(
      sets: {...state.sets, set.id: set},
    );

    notifyListeners();
  }

  void updateTerm(int setId, TermModel term) async {
    dataRepository.updateTerm(term);

    final set = state.sets[setId]!;

    state = state.copyWith(
      sets: {
        ...state.sets,
        setId: set.copyWith(
          terms: set.terms.copyWith(
            terms: {...set.terms.terms, term.id: term},
          ),
        ),
      },
    );

    final indexInLastAddedTerms =
        lastAddedTerms.indexWhere((element) => element.id == term.id);

    if (indexInLastAddedTerms != -1) {
      lastAddedTerms[indexInLastAddedTerms] = term;
      lastAddedTerms = lastAddedTerms.toList();
    }

    notifyListeners();
  }

  void removeSet(int id) async {
    dataRepository.deleteSet(id);

    state = state.copyWith(
      ids: state.ids.where((setId) => setId != id).toList(),
      sets: Map.fromEntries(
        state.sets.entries.where((entry) => entry.key != id),
      ),
    );

    notifyListeners();
  }

  void removeTerm(int setId, int termId) async {
    dataRepository.deleteTerm(termId);

    final set = state.sets[setId]!;

    state = state.copyWith(sets: {
      ...state.sets,
      setId: set.copyWith(
        terms: set.terms.copyWith(
          ids: set.terms.ids.where((id) => id != termId).toList(),
          terms: Map.fromEntries(
            set.terms.terms.entries.where((entry) => entry.key != termId),
          ),
        ),
      )
    });

    final indexInLastAddedTerms =
        lastAddedTerms.indexWhere((element) => element.id == termId);

    if (indexInLastAddedTerms != -1) {
      lastAddedTerms.removeAt(indexInLastAddedTerms);
      lastAddedTerms = lastAddedTerms.toList();
    }

    notifyListeners();
  }

  Future<int> copySet(int id) async {
    final setCopy = await dataRepository.copySet(id);

    state = state.copyWith(
      ids: [...state.ids, setCopy.id],
      sets: {...state.sets, setCopy.id: setCopy},
    );

    notifyListeners();

    return setCopy.id;
  }

  bool isSetCopied(int setId) {
    return state.ids.any((id) => state.sets[id]!.parentId == setId);
  }

  TermModel? getTermById(int id) {
    final sets = state.sets;

    for (var i = 0; i < state.ids.length; i++) {
      final setId = state.ids[i];
      final set = sets[setId];

      if (set != null && set.terms.terms[id] != null) {
        return set.terms.terms[id]!;
      }
    }

    return null;
  }

  List<int> getUserSetIds() {
    return state.ids
        .where((id) => !state.sets[id]!.isDefault)
        .toList();
  }
}
