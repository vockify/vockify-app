import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/loader.dart';

class LayoutWidget extends StatelessWidget {
  final String? title;
  final Widget body;
  final Color? backgroundColor;
  final List<Widget> actions;
  final bool isLoading;

  LayoutWidget({
    Key? key,
    this.title,
    required this.body,
    this.backgroundColor,
    this.actions = const [],
    this.isLoading = false,
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
      body: _buildBody(body, isLoading),
    );
  }

  Widget _buildBody(Widget body, [bool isLoading = false]) {
    if (isLoading) {
      return Center(
        child: LoaderWidget(),
      );
    }

    return body;
  }

  Widget? _buildGoBackArrow(BuildContext context) {
    if (!Navigator.of(context).canPop()) {
      return null;
    }

    return IconButton(
      icon: new FaIcon(FontAwesomeIcons.angleLeft),
      color: VockifyColors.prussianBlue,
      onPressed: () {
        Navigator.of(context).pop();
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
