import 'package:flutter/material.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class TranscriptionTextWidget extends StatelessWidget {
  final String term;
  final String transcription;

  const TranscriptionTextWidget({
    Key key,
    @required this.term,
    @required this.transcription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: RichText(
        text: TextSpan(
          text: term,
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: 20,
              ),
          children: [
            TextSpan(
              text: ' [${transcription}]',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: 20,
                    color: VockifyColors.lightSteelBlue,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
