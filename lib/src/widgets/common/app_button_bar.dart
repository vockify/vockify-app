import 'package:flutter/material.dart';

class AppButtonBarWidget extends StatelessWidget {
  final Iterable<Widget> children;

  const AppButtonBarWidget({Key key, @required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 2.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
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
