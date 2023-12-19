import 'package:flutter/material.dart';
import 'package:vockify/src/pages/tour/widgets/tour.dart';
import 'package:vockify/src/widgets/layout.dart';

class TourPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      title: 'VOCKIFY',
      body: TourWidget(),
    );
  }
}
