import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/models/home_item.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/screens/start_screen.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:vockify/src/widgets/common/loader.dart';
import 'package:vockify/src/widgets/home_navigator.dart';

final NavigatorSettings = {
  HomeItem.main: HomeNavigatorSettings(GlobalKey<NavigatorState>(), Routes.main),
};

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomeWidget> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: (Store<AppState> store) => store.state.bottomNavigationItemIndex,
      builder: (BuildContext context, currentItem) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: VockifyColors.white,
          bottomNavigationBar: VockifyBottomNavigationBar(
            currentItem: currentItem,
          ),
          body: Stack(
            children: <Widget>[
              Offstage(
                offstage: currentItem != HomeItem.start,
                child: StartScreenWidget(),
              ),
              Offstage(
                offstage: currentItem != HomeItem.main,
                child: HomeNavigatorWidget(settings: NavigatorSettings[HomeItem.main]!),
              ),
              StoreConnector<AppState, bool>(
                distinct: true,
                converter: (store) => isLoading(store.state),
                builder: (context, isLoading) {
                  if (isLoading) {
                    return Container(
                      color: Color(0x00000000),
                      child: Center(
                        child: LoaderWidget(),
                      ),
                    );
                  }

                  return Container();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
