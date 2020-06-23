import 'package:flutter/material.dart';
import 'package:vockify/src/redux/actions/sets/request_public_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/unset_public_sets_action.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/pages/search/search.dart';

class SearchPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      route: Routes.search,
      actions: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          child: Icon(
            Icons.search,
            color: VockifyColors.white,
          ),
          onPressed: () {},
          padding: EdgeInsets.all(16),
          shape: CircleBorder(),
        ),
      ],
      onInit: (store) {
        store.dispatch(RequestPublicSetsAction());
      },
      onDispose: (store) {
        store.dispatch(UnsetPublicSetsAction());
      },
      isLoadingConverter: (store) => store.state.sets.user.loader == LoaderState.isLoading,
      body: SearchWidget(),
    );
  }
}
