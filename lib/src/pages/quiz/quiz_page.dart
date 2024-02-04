import 'package:flutter/material.dart';
import 'package:vockify/src/pages/quiz/widgets/quiz.dart';
import 'package:vockify/src/widgets/layout.dart';

class QuizPageWidget extends StatelessWidget {
  final int setId;

  const QuizPageWidget({Key? key, required this.setId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      body: QuizWidget(
        setId: setId,
      ),
    );
  }
}
