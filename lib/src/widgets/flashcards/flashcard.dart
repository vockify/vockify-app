import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class FlashCardWidget extends StatelessWidget {
  final String text;

  const FlashCardWidget({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: VockifyColors.white,
        borderRadius: BorderRadius.all(Radius.circular(4)),
        boxShadow: [
          BoxShadow(
            color: VockifyColors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 24,
              ),
        ),
      ),
    );
  }
}
