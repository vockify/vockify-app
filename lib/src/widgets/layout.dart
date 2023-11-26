import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/navigation/navigate_to_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/services/amplitude.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/loader.dart';

class LayoutWidget extends StatelessWidget {
  final String route;
  final String? title;
  final Widget body;
  final Color? backgroundColor;
  final List<Widget> actions;
  final bool isContextNavigation;
  final void Function(Store<AppState>)? onInit;
  final void Function(Store<AppState>)? onDispose;
  final bool Function(Store<AppState>)? isLoading;

  LayoutWidget({
    Key? key,
    required this.route,
    this.title,
    required this.body,
    this.backgroundColor,
    this.actions = const [],
    this.isContextNavigation = true,
    this.onInit,
    this.onDispose,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor ?? VockifyColors.ghostWhite,
      appBar: AppBar(
        backgroundColor: VockifyColors.ghostWhite,
        elevation: 0,
        centerTitle: true,
        title: _buildTitle(),
        leading: _buildGoBackArrow(context),
        automaticallyImplyLeading: false,
        actions: actions,
      ),
      body: StoreConnector<AppState, bool>(
        distinct: true,
        converter: isLoading ?? (store) => false,
        onDispose: onDispose ?? null,
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

  Widget? _buildGoBackArrow(BuildContext context) {
    if (!Navigator.of(context).canPop()) {
      return null;
    }

    return IconButton(
      icon: new FaIcon(FontAwesomeIcons.angleLeft),
      color: VockifyColors.prussianBlue,
      onPressed: () {
        if (isContextNavigation) {
          Navigator.of(context).pop();
        } else {
          dispatcher.dispatch(NavigateToAction.pop());
        }

        amplitude.logEvent('back_arrow_button_clicked', eventProperties: {
          'current_route': ModalRoute.of(context)?.settings.name,
        });
      },
    );
  }

  Widget? _buildTitle() {
    if (title != null) {
      return Text(
        title!,
        style: TextStyle(
          color: VockifyColors.prussianBlue,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return null;
  }
}
