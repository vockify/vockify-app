import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/api/dto/term_dto.dart';
import 'package:vockify/src/redux/actions/request_add_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state.dart';
import 'package:vockify/src/widgets/terms.dart';

class TermModalViewModel {
  final BuiltList<SetState> sets;
  final Function(TermDto) requestAddTerm;
  final Function(int) close;

  TermModalViewModel({this.requestAddTerm, this.close, this.sets});

  static TermModalViewModel fromStore(Store<AppState> store) {
    return TermModalViewModel(
      sets: store.state.sets,
      close: (int setId) => store.dispatch(NavigateToAction.replace(TermsWidget.route, arguments: setId)),
      requestAddTerm: (term) => store.dispatch(RequestAddTermAction(term)),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TermModalViewModel && this.sets == other.sets;
  }

  @override
  int get hashCode => sets.hashCode;
}
