import 'package:flutter/material.dart';
import 'package:vockify/src/widgets/common/primary_button.dart';

class EmptyWidget extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback onPressed;

  const EmptyWidget({
    Key key,
    @required this.text,
    this.buttonText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          if (buttonText != null && onPressed != null)
            PrimaryButtonWidget(
              text: buttonText,
              onPressed: onPressed,
            ),
        ],
      ),
    );
  }
}
