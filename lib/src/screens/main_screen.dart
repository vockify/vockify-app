import 'package:flutter/material.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/redux/actions/sets/request_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/unset_sets_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/app_bar_action.dart';
import 'package:vockify/src/widgets/layout.dart';
import 'package:vockify/src/widgets/set_list/set_list.dart';

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
        store.dispatch(RequestSetsAction(type: SetType.all));
      },
      onDispose: (store) {
        store.dispatch(UnsetSetsAction());
      },
      isLoading: (store) => getSetLoader(store.state) == LoaderState.isLoading,
      body: SetListWidget(),
    );
  }
}
