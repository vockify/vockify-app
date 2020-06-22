import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/common/loader.dart';

class AppLayoutWidget extends StatelessWidget {
  final String route;
  final String title;
  final Widget body;
  final List<Widget> actions;
  final String redirectBackRoute;
  final Function(Store<AppState>) onInit;
  final bool isContextNavigation;

  AppLayoutWidget({
    Key key,
    @required this.route,
    this.title,
    this.body,
    this.actions = const [],
    this.redirectBackRoute,
    this.onInit,
    this.isContextNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      converter: (store) => isLoading(store.state, route),
      distinct: true,
      onInit: (store) {
        if (onInit != null) {
          onInit(store);
        }
      },
      builder: (context, isLoading) {
        return Scaffold(
          backgroundColor: VockifyColors.white,
          appBar: AppBar(
            title: title != null
                ? Text(
                    title,
                    style: TextStyle(color: VockifyColors.white),
                  )
                : null,
            leading: _goBackArrow(context),
            automaticallyImplyLeading: false,
            actions: actions,
          ),
          body: isLoading
              ? Center(
                  child: LoaderWidget(),
                )
              : body,
        );
      },
    );
  }

  Widget _goBackArrow(BuildContext context) {
    if (!Navigator.of(context).canPop() && redirectBackRoute == null) {
      return null;
    }

    final store = StoreProvider.of<AppState>(context);

    return IconButton(
      icon: new Icon(Icons.arrow_back),
      onPressed: () {
        if (redirectBackRoute != null) {
          store.dispatch(NavigateToAction.pushNamedAndRemoveUntil(redirectBackRoute, (route) => false));
        } else {
          if (isContextNavigation) {
            Navigator.of(context).pop();
          } else {
            store.dispatch(NavigateToAction.pop());
          }
        }
      },
    );
  }
}
