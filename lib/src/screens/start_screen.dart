import 'package:flutter/material.dart';
import 'package:vockify/src/redux/actions/sets/request_user_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/unset_user_sets_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/add_user_term/add_user_term.dart';
import 'package:vockify/src/widgets/layout.dart';

class StartScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      route: Routes.start,
      onInit: (store) {
        store.dispatch(RequestUserSetsAction());
      },
      onDispose: (store) {
        store.dispatch(UnsetUserSetsAction());
      },
      isLoading: (store) => getUserSetLoader(store.state) == LoaderState.isLoading,
      body: AddUserTermWidget(),
    );
  }
}
