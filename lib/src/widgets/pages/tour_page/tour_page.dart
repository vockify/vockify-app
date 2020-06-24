import 'package:flutter/material.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/layout.dart';
import 'package:vockify/src/widgets/pages/tour_page/tour.dart';

class TourPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      route: Routes.tour,
      title: 'VOCKIFY',
      body: TourWidget(),
    );
  }
}
