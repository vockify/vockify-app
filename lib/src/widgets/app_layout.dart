import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/vockify_colors.dart';

class AppLayoutWidget extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget> actions;

  const AppLayoutWidget({
    Key key,
    this.title,
    this.body,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: VockifyColors.white),
        ),
        leading: _goBackArrow(context),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          ...actions,
          StoreConnector<AppState, String>(
            converter: (store) => store.state.user.avatar,
            builder: (context, url) {
              return _userAvatar(url);
            },
          ),
        ],
      ),
      body: body,
    );
  }

  Widget _goBackArrow(BuildContext context) {
    if (!Navigator.of(context).canPop()) {
      return null;
    }

    return StoreConnector<AppState, Function>(
      converter: (store) => store.dispatch,
      distinct: true,
      builder: (context, dispatch) {
        return new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            dispatch(NavigateToAction.pop());
          },
        );
      },
    );
  }

  Widget _userAvatar(String url) {
    return url != null
        ? Padding(
            padding: EdgeInsets.only(right: 16, left: 8),
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
