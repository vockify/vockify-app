import 'package:flutter/material.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/pages/tour/tour.dart';

class TourPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      route: Routes.tour,
      title: 'VOCKIFY',
      body: TourWidget(),
    );
  }
}
