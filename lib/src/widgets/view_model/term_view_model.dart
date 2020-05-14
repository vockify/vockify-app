import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/api/dto/term_dto.dart';
import 'package:vockify/src/redux/actions/request_add_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state.dart';
import 'package:vockify/src/widgets/terms.dart';

class TermViewModel {
  final BuiltList<SetState> sets;
  final Function(TermDto) requestAddTerm;
  final Function(int) navigateBack;

  TermViewModel({this.requestAddTerm, this.navigateBack, this.sets});

  static TermViewModel fromStore(Store<AppState> store) {
    return TermViewModel(
      sets: store.state.sets,
      navigateBack: (int setId) => store.dispatch(NavigateToAction.pop()),
      requestAddTerm: (term) => store.dispatch(RequestAddTermAction(term)),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TermViewModel && this.sets == other.sets;
  }

  @override
  int get hashCode => sets.hashCode;
}
