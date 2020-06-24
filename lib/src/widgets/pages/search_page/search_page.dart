import 'package:flutter/material.dart';
import 'package:vockify/src/redux/actions/sets/request_public_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/unset_public_sets_action.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/layout.dart';
import 'package:vockify/src/widgets/public_set_list/public_set_list.dart';

class SearchPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      route: Routes.search,
      onInit: (store) {
        store.dispatch(RequestPublicSetsAction());
      },
      onDispose: (store) {
        store.dispatch(UnsetPublicSetsAction());
      },
      isLoading: (store) => store.state.sets.public.loader == LoaderState.isLoading,
      body: PublicSetListWidget(),
    );
  }
}
