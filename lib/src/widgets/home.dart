import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/models/bar_model.dart';
import 'package:vockify/src/models/home_item.dart';
import 'package:vockify/src/pages/sets/sets_page.dart';
import 'package:vockify/src/pages/start/start_page.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:vockify/src/widgets/home_navigator.dart';

final NavigatorSettings = {
  HomeItem.main:
      HomeNavigatorSettings(GlobalKey<NavigatorState>(), SetsPageWidget()),
};

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomeWidget> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final currentItem =
        context.select<BarModel, HomeItem>((value) => value.currentItem);

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
            child: StartPageWidget(),
          ),
          Offstage(
            offstage: currentItem != HomeItem.main,
            child: HomeNavigatorWidget(
              settings: NavigatorSettings[HomeItem.main]!,
            ),
          ),
          // StoreConnector<AppState, bool>(
          //   distinct: true,
          //   converter: (store) => isLoading(store.state),
          //   builder: (context, isLoading) {
          //     if (isLoading) {
          //       return Container(
          //         color: Color(0x00000000),
          //         child: Center(
          //           child: LoaderWidget(),
          //         ),
          //       );
          //     }

          //     return Container();
          //   },
          // ),
        ],
      ),
    );
  }
}
