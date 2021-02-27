import 'package:flutter/material.dart';
import 'package:vockify/src/redux/actions/request_initial_data_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/layout.dart';
import 'package:vockify/src/widgets/start_user_term_form/start_user_term_form.dart';

class StartScreenWidget extends StatelessWidget {
  final String term;

  const StartScreenWidget({Key key, this.term}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      route: Routes.start,
      onInit: (store) {
        store.dispatch(RequestInitialDataAction());
      },
      isLoading: (store) =>
          getSetLoader(store.state) == LoaderState.isLoading || getHistoryLoader(store.state) == LoaderState.isLoading,
      body: StartUserTermFormWidget(term: term),
    );
  }
}
