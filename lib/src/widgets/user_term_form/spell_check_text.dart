import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SpellCheckTextWidget extends StatelessWidget {
  final Function() onTap;
  final String text;
  final double padding;

  const SpellCheckTextWidget({
    Key key,
    @required this.onTap,
    @required this.text,
    this.padding = 0,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: 16,
                color: Colors.grey,
              ),
          children: <TextSpan>[
            TextSpan(text: 'Возможно вы имели в виду: '),
            TextSpan(
              text: text,
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}
