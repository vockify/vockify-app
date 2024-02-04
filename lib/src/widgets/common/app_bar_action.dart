import 'package:flutter/material.dart';

class AppBarAction extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? icon;

  const AppBarAction({Key? key, required this.onPressed, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints(
        minWidth: 42,
        minHeight: 42,
      ),
      onPressed: onPressed,
      child: icon,
      padding: EdgeInsets.all(16),
      shape: CircleBorder(),
    );
  }
}
