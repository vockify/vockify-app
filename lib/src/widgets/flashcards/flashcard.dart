import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/audio_text/audio_text.dart';

class FlashCardWidget extends StatelessWidget {
  final String text;
  final bool isAudio;

  const FlashCardWidget({
    Key key,
    @required this.text,
    this.isAudio = false,
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
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 28,
                ),
              ),
            )
          ),
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.threesixty,
              size: 32,
              color: VockifyColors.black.withOpacity(0.4),
            ),
          ),
          if (isAudio)
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(16),
              child: AudioTextWidget(
                text: text,
              ),
            )
        ],
      ),
    );
  }
}
