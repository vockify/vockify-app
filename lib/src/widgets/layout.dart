import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/loader.dart';

class LayoutWidget extends StatelessWidget {
  final String route;
  final String title;
  final Widget body;
  final Color backgroundColor;
  final List<Widget> actions;
  final String redirectBackRoute;
  final bool isContextNavigation;
  final Function(Store<AppState>) onInit;
  final Function(Store<AppState>) onDispose;
  final bool Function(Store<AppState>) isLoading;

  LayoutWidget({
    Key key,
    @required this.route,
    this.title,
    this.body,
    this.backgroundColor,
    this.actions = const [],
    this.isContextNavigation = true,
    this.redirectBackRoute,
    this.onInit,
    this.onDispose,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor ?? VockifyColors.white,
      appBar: AppBar(
        title: _buildTitle(),
        leading: _buildGoBackArrow(context),
        automaticallyImplyLeading: false,
        actions: actions,
      ),
      body: StoreConnector<AppState, bool>(
        distinct: true,
        converter: isLoading != null ? isLoading : (store) => false,
        onDispose: onDispose != null ? onDispose : null,
        onInit: onInit != null ? onInit : null,
        builder: (context, isLoading) {
          if (isLoading) {
            return Center(
              child: LoaderWidget(),
            );
          }

          return body;
        },
      ),
    );
  }

  Widget _buildGoBackArrow(BuildContext context) {
    if (!Navigator.of(context).canPop() && redirectBackRoute == null) {
      return null;
    }

    return IconButton(
      icon: new Icon(Icons.arrow_back),
      onPressed: () {
        if (redirectBackRoute != null) {
          dispatcher.dispatch(NavigateToAction.pushNamedAndRemoveUntil(redirectBackRoute, (route) => false));
        } else {
          if (isContextNavigation) {
            Navigator.of(context).pop();
          } else {
            dispatcher.dispatch(NavigateToAction.pop());
          }
        }
      },
    );
  }

  Widget _buildTitle() {
    if (title != null) {
      return Text(
        title,
        style: TextStyle(color: VockifyColors.white),
      );
    }

    return null;
  }
}
