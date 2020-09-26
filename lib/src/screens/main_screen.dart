import 'package:flutter/material.dart';
import 'package:vockify/src/redux/actions/sets/request_user_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/unset_user_sets_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/app_bar_action.dart';
import 'package:vockify/src/widgets/layout.dart';
import 'package:vockify/src/widgets/user_set_list/user_set_list.dart';

class MainScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      route: Routes.main,
      actions: <Widget>[
        AppBarAction(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.userSet, arguments: {'id': null});
          },
          icon: Icon(
            Icons.add_circle,
            color: VockifyColors.white,
          ),
        ),
      ],
      onInit: (store) {
        store.dispatch(RequestUserSetsAction());
      },
      onDispose: (store) {
        store.dispatch(UnsetUserSetsAction());
      },
      isLoading: (store) => getUserSetLoader(store.state) == LoaderState.isLoading,
      body: UserSetListWidget(),
    );
  }
}
