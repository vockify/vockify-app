import 'package:flutter/material.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/layout.dart';
import 'package:vockify/src/widgets/set_list/set_list.dart';

class MainScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      title: 'Словари',
      route: Routes.main,
      isContextNavigation: true,
      isLoading: (store) => getSetLoader(store.state) == LoaderState.isLoading,
      body: SetListWidget(),
    );
  }
}
