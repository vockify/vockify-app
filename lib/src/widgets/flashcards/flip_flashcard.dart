import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vockify/src/widgets/flashcards/flashcard.dart';

class FlipFlashCardWidget extends StatefulWidget {
  final String term;
  final String definition;

  const FlipFlashCardWidget({
    Key key,
    @required this.term,
    @required this.definition,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FlipFlashCardState();
}

class _FlipFlashCardState extends State<FlipFlashCardWidget> with SingleTickerProviderStateMixin {
  Animation<double> _flipAnimation;
  AnimationController _flipAnimationController;
  AnimationStatus _flipAnimationStatus = AnimationStatus.dismissed;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.rotationY(pi * _flipAnimation.value),
      child: _flipAnimation.value <= 0.5
          ? _buildFlipFlashCard(widget.term)
          : Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.rotationY(pi),
              child: _buildFlipFlashCard(widget.definition),
            ),
    );
  }

  @override
  void dispose() {
    _flipAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _flipAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _flipAnimation = Tween<double>(end: 1, begin: 0).animate(_flipAnimationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _flipAnimationStatus = status;
      });
  }

  Widget _buildFlipFlashCard(String text) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (_flipAnimationStatus == AnimationStatus.dismissed) {
          _flipAnimationController.forward();
        } else if (_flipAnimationStatus == AnimationStatus.completed) {
          _flipAnimationController.reverse();
        }
      },
      child: FlashCardWidget(text: text),
    );
  }
}
