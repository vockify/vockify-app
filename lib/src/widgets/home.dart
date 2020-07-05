import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/loader.dart';
import 'package:vockify/src/widgets/home_navigator.dart';
import 'package:vockify/src/widgets/pages/profile_page/profile_page.dart';

enum HomeItem {
  main,
  search,
  profile,
}

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomeWidget> {
  StreamSubscription _intentSubscription;

  HomeItem _currentItem = HomeItem.main;

  final _navigatorSettings = {
    HomeItem.main: HomeNavigatorSettings(GlobalKey<NavigatorState>(), Routes.main),
    HomeItem.search: HomeNavigatorSettings(GlobalKey<NavigatorState>(), Routes.search),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: VockifyColors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentItem.index,
        onTap: (index) {
          final item = HomeItem.values[index];

          if (_navigatorSettings.containsKey(item) && item == _currentItem) {
            final settings = _navigatorSettings[item];
            settings.key.currentState.popUntil((route) => route.settings.name == settings.initialRoute);
          }

          setState(() {
            _currentItem = item;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Мои словари')),
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('Поиск словарей')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Профиль')),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: _currentItem != HomeItem.main,
            child: HomeNavigatorWidget(settings: _navigatorSettings[HomeItem.main]),
          ),
          Offstage(
            offstage: _currentItem != HomeItem.search,
            child: HomeNavigatorWidget(settings: _navigatorSettings[HomeItem.search]),
          ),
          Offstage(
            offstage: _currentItem != HomeItem.profile,
            child: ProfilePageWidget(),
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
      dispatcher.dispatch(
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
