import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';

class AppLayoutWidget extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget> actions;
  final String redirectBackRoute;
  final bool profile;

  AppLayoutWidget({
    Key key,
    this.title,
    this.body,
    this.actions = const [],
    this.redirectBackRoute,
    this.profile = true,
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
          if (profile) StoreConnector<AppState, String>(
            converter: (store) => store.state.user.avatar,
            builder: (context, url) {
              return _userAvatar(context, url);
            },
          ),
        ],
      ),
      body: body,
    );
  }

  Widget _goBackArrow(BuildContext context) {
    if (!Navigator.of(context).canPop() && redirectBackRoute == null) {
      return null;
    }

    return StoreConnector<AppState, Function>(
      converter: (store) => store.dispatch,
      distinct: true,
      builder: (context, dispatch) {
        return new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              dispatch(NavigateToAction.pop());
            } else {
              if (redirectBackRoute != null) {
                dispatch(NavigateToAction.pushNamedAndRemoveUntil(redirectBackRoute, (route) => false));
              } else {
                dispatch(NavigateToAction.pushNamedAndRemoveUntil(Routes.sets, (route) => false));
              }
            }
          },
        );
      },
    );
  }

  Widget _userAvatar(BuildContext context, String url) {
    final store = StoreProvider.of<AppState>(context, listen: false);
    return url != null
        ? Padding(
            padding: EdgeInsets.only(right: 16, left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => store.dispatch(NavigateToAction.push(Routes.profile)),
                  child: CircleAvatar(backgroundImage: NetworkImage(url)),
                ),
              ],
            ),
          )
        : Container();
  }
}
