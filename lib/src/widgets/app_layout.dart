import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/common/loader.dart';

class AppLayoutWidget extends StatelessWidget {
  final String route;
  final String title;
  final Widget body;
  final List<Widget> actions;
  final String redirectBackRoute;
  final bool isContextNavigation;
  final Function(Store<AppState>) onInit;
  final Function(Store<AppState>) onDispose;
  final bool Function(Store<AppState>) isLoadingConverter;

  AppLayoutWidget({
    Key key,
    @required this.route,
    this.title,
    this.body,
    this.actions = const [],
    this.redirectBackRoute,
    this.isContextNavigation = true,
    this.onInit,
    this.onDispose,
    this.isLoadingConverter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      distinct: true,
      converter: isLoadingConverter != null ? isLoadingConverter : (store) => false,
      onDispose: onDispose != null ? onDispose : null,
      onInit: onInit != null ? onInit : null,
      builder: (context, isLoading) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
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
