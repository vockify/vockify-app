import 'package:flutter/material.dart';
import 'package:vockify/src/vockify_colors.dart';

class LoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(VockifyColors.fulvous),
      strokeWidth: 3.0,
    );
  }
}
