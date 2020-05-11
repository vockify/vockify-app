import 'package:flutter/material.dart';

class LayoutButtonWrapperWidget extends StatelessWidget {
  final Widget child;

  const LayoutButtonWrapperWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
