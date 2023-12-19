import 'package:flutter/material.dart';
import 'package:vockify/src/pages/flashcards/widgets/flashcards.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/layout.dart';

class FlashcardsPageWidget extends StatelessWidget {
  final int setId;

  const FlashcardsPageWidget({Key? key, required this.setId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      backgroundColor: VockifyColors.ghostWhite,
      body: FlashcardsWidget(
        setId: setId,
      ),
    );
  }
}
