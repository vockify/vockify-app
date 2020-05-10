import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AppLayoutWidget extends StatelessWidget {
  final String title;
  final Widget body;

  const AppLayoutWidget({Key key, this.title, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          StoreConnector<AppState, String>(
            converter: (store) => store.state.userAvatar,
            builder: (context, url) {
              return _userAvatar(url);
            },
          ),
        ],
      ),
      body: body,
    );
  }

  Widget _userAvatar(String url) {
    return url != null
        ? CircleAvatar(
            backgroundImage: NetworkImage(url),
          )
        : Container();
  }
}
