import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AppLayoutWidget extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget floatingActionButton;

  const AppLayoutWidget({Key key, this.title, this.body, this.floatingActionButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
