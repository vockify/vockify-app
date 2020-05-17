import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/api/dto/term_dto.dart';
import 'package:vockify/src/redux/actions/request_add_term_action.dart';
import 'package:vockify/src/redux/actions/request_update_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state.dart';
import 'package:vockify/src/router/route_list.dart';
import 'package:vockify/src/router/router.dart';

class TermViewModel {
  final BuiltList<SetState> sets;
  final Function(TermDto) requestSaveTerm;
  final VoidCallback navigateBack;
  final Function(String) navigateToTerms;

  TermViewModel({
    this.requestSaveTerm,
    this.navigateBack,
    this.sets,
    this.navigateToTerms,
  });

  static TermViewModel fromStore(Store<AppState> store) {
    return TermViewModel(
      sets: store.state.sets,
      navigateBack: () => store.dispatch(NavigateToAction.pop()),
      navigateToTerms: (String setId) => store.dispatch(NavigateToAction.push(Router.routeToPath(RouteList.terms, {
        "id": setId,
      }))),
      requestSaveTerm: (term) =>
          term.id > 0 ? store.dispatch(RequestUpdateTermAction(term)) : store.dispatch(RequestAddTermAction(term)),
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
