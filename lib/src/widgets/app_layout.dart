import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AppLayoutWidget extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget floatingActionButton;
  final String redirectBackRoute;
  final Object redirectBackArguments;

  const AppLayoutWidget({
    Key key,
    this.title,
    this.body,
    this.floatingActionButton,
    this.redirectBackRoute,
    this.redirectBackArguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: _goBackArrow(),
        actions: <Widget>[
          StoreConnector<AppState, String>(
            converter: (store) => store.state.user.avatar,
            builder: (context, url) {
              return _userAvatar(url);
            },
          ),
        ],
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }

  Widget _goBackArrow() {
    if (redirectBackRoute == null) {
      return Container();
    }

    return StoreConnector<AppState, Function>(
      converter: (store) => store.dispatch,
      distinct: true,
      builder: (context, dispatch) {
        return new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            dispatch(NavigateToAction.replace(redirectBackRoute, arguments: redirectBackArguments));
          },
        );
      },
    );
  }

  Widget _userAvatar(String url) {
    return url != null
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(backgroundImage: NetworkImage(url)),
              ],
            ),
          )
        : Container();
  }
}
