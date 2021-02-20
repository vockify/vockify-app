import 'package:flutter/material.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/primary_button.dart';

class EmptyWidget extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback onPressed;
  final IconData icon;

  const EmptyWidget({
    Key key,
    @required this.text,
    this.buttonText,
    this.onPressed,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: VockifyColors.black,
              size: 64,
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(48, 0, 48, 16),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: VockifyColors.black,
                    fontSize: 20,
                    height: 1.3,
                  ),
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
