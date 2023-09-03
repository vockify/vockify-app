import 'package:flutter/material.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class AppButtonBarWidget extends StatelessWidget {
  final List<Widget> children;

  const AppButtonBarWidget({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: VockifyColors.grey,
          ),
        ),
      ),
      height: 52,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children
            .map(
              (child) => Expanded(
                child: child,
              ),
            )
            .toList(),
      ),
    );
  }
}
