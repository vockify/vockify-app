import 'package:flutter/material.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButtonWidget({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: VockifyColors.fulvous,
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: VockifyColors.white,
              fontSize: 16,
            ),
      ),
    );
  }
}
