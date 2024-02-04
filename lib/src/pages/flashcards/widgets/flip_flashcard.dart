import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vockify/src/services/amplitude.dart';
import 'package:vockify/src/pages/flashcards/widgets/flashcard.dart';

class FlipFlashCardWidget extends StatefulWidget {
  final String term;
  final String definition;

  const FlipFlashCardWidget({
    Key? key,
    required this.term,
    required this.definition,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FlipFlashCardState();
}

class _FlipFlashCardState extends State<FlipFlashCardWidget> with SingleTickerProviderStateMixin {
  bool _showFrontSide = true;
  AnimationStatus _animationStatus = AnimationStatus.completed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: _buildFlipAnimation(),
    );
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        transitionBuilder: _transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [if (widget != null) widget, ...list]),
        child: _buildFlipFlashCard(),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation)
      ..addStatusListener((status) {
        _animationStatus = status;
      });
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  void _switchCard() {
    if (_animationStatus != AnimationStatus.completed) {
      return;
    }

    amplitude.logEvent('flashcards_flipped');
    setState(() {
      _showFrontSide = !_showFrontSide;
    });
  }

  Widget _buildFlipFlashCard() {
    return FlashCardWidget(
      key: ValueKey(_showFrontSide),
      text: _showFrontSide ? widget.term : widget.definition,
      isAudio: _showFrontSide,
    );
  }
}
