import 'package:flutter/material.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/app_layout.dart';

class SearchPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      route: Routes.search,
      title: 'SEARCH',
      body: Center(
        child: Text('Search Page'),
      ),
    );
  }
}
