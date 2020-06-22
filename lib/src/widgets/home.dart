import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/router.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/pages/profile/profile_page.dart';
import 'package:vockify/src/widgets/pages/search/search_page.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class NavigatorSetting {
  final GlobalKey<NavigatorState> key;
  final String initialRoute;

  NavigatorSetting(this.key, this.initialRoute);
}

class _HomeState extends State<HomeWidget> {
  StreamSubscription _intentSubscription;

  int _currentIndex = 0;

  final _navigatorSettings = [
    NavigatorSetting(GlobalKey<NavigatorState>(), Routes.sets),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VockifyColors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            if (index < _navigatorSettings.length && index == _currentIndex) {
              final key = _navigatorSettings[index].key;
              final initialRoute = _navigatorSettings[index].initialRoute;

              key.currentState.popUntil((route) => route.settings.name == initialRoute);
            }

            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Мои словари')),
          BottomNavigationBarItem(icon: Icon(Icons.local_library), title: Text('Все словари')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Профиль')),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: _currentIndex != 0,
            child: Navigator(
              key: _navigatorSettings[0].key,
              onGenerateRoute: Router.getRoute,
              onGenerateInitialRoutes: (navigator, route) => [
                Router.getRoute(RouteSettings(name: _navigatorSettings[0].initialRoute)),
              ],
            ),
          ),
          Offstage(
            offstage: _currentIndex != 1,
            child: SearchPageWidget(),
          ),
          Offstage(
            offstage: _currentIndex != 2,
            child: ProfilePageWidget(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _intentSubscription?.cancel();
  }

  @override
  void initState() {
    super.initState();

    _intentSubscription = ReceiveSharingIntent.getTextStream().listen(
      _goToShare,
      onError: (error) {
        print("getTextStream error: $error");
      },
    );
  }

  void _goToShare(String value) {
    if (value != null) {
      final store = StoreProvider.of<AppState>(context);

      store.dispatch(
        NavigateToAction.pushNamedAndRemoveUntil(
          Routes.share,
          (route) => route.settings.name != Routes.share,
          arguments: {
            'term': value,
          },
        ),
      );
    }
  }
}
