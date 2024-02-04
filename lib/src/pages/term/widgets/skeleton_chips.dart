import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vockify/src/theme/vockify_colors.dart';

class SkeletonChipsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SkeletonChipsWidgetState();
}

class _SkeletonChipsWidgetState extends State<SkeletonChipsWidget> {
  bool _isColored = false;

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: 300,
            height: 30,
            decoration: BoxDecoration(
              color: _isColored ? VockifyColors.lightSteelBlue : VockifyColors.ghostWhite,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            onEnd: () {
              setState(() {
                _isColored = !_isColored;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: 100,
            height: 30,
            decoration: BoxDecoration(
              color: _isColored ? VockifyColors.lightSteelBlue : VockifyColors.ghostWhite,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    Timer(
      Duration(microseconds: 500),
      () {
        if (this.mounted) {
          setState(() {
            _isColored = !_isColored;
          });
        }
      },
    );
  }
}
