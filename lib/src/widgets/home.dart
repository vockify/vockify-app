import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/screens/profile_screen.dart';
import 'package:vockify/src/screens/start_screen.dart';
import 'package:vockify/src/services/amplitude.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/loader.dart';
import 'package:vockify/src/widgets/home_navigator.dart';

enum HomeItem {
  start,
  main,
  profile,
}

class HomeWidget extends StatefulWidget {
  final String intent;

  const HomeWidget({Key key, this.intent}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomeWidget> {
  StreamSubscription _intentSubscription;

  HomeItem _currentItem = HomeItem.start;
  String _intent;

  final _navigatorSettings = {
    HomeItem.main: HomeNavigatorSettings(GlobalKey<NavigatorState>(), Routes.main),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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

          amplitude.logEvent('navigation_bar_clicked', eventProperties: {
            'name': item,
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Новое слово',
            backgroundColor: VockifyColors.fulvous,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Словари',
            backgroundColor: VockifyColors.fulvous,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
            backgroundColor: VockifyColors.fulvous,
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: _currentItem != HomeItem.start,
            child: StartScreenWidget(term: _intent),
          ),
          Offstage(
            offstage: _currentItem != HomeItem.main,
            child: HomeNavigatorWidget(settings: _navigatorSettings[HomeItem.main]),
          ),
          Offstage(
            offstage: _currentItem != HomeItem.profile,
            child: ProfileScreenWidget(),
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

    if (widget.intent != null) {
      _intent = widget.intent;
    }

    _intentSubscription = ReceiveSharingIntent.getTextStream().listen(
      _goToShare,
      onError: (error) {
        print("getTextStream error: $error");
      },
    );
  }

  void _goToShare(String value) {
    if (value != null) {
      setState(() {
        _intent = value;
        _currentItem = HomeItem.start;
      });
    }
  }
}
