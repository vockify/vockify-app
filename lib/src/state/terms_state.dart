// import 'dart:collection';

// import 'package:flutter/widgets.dart';
// import 'package:vockify/src/services/data_repository/data_repository.dart';
// import 'package:vockify/src/models/term_model.dart';

// class TermsState extends ChangeNotifier {
//   bool _isInit = false;
//   bool get isInit => _isInit;

//   final List<int> _ids = [];
//   UnmodifiableListView<int> get ids => UnmodifiableListView(_ids);

//   final Map<int, TermModel> _terms = Map();
//   UnmodifiableMapView<int, TermModel> get terms => UnmodifiableMapView(_terms);

//   void init(int setId) async {
//     final terms = await dataRepository.getTerms(setId: setId);

//     _ids.clear();
//     _ids.addAll(terms.map((set) => set.id));

//     final entries = terms.map((set) => MapEntry(set.id, set));
//     final map = Map.fromEntries(entries);

//     _terms.clear();
//     _terms.addAll(map);

//     notifyListeners();
//   }

//   void add(TermModel term) async {
//     await dataRepository.addTerm(term);

//     _ids.add(term.id);
//     _terms.addEntries([MapEntry(term.id, term)]);

//     notifyListeners();
//   }

//   void remove(int id) async {
//     await dataRepository.deleteTerm(id);

//     _ids.remove(id);
//     _terms.remove(id);

//     notifyListeners();
//   }
// }
