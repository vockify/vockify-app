import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vockify/src/navigation/navigation_holder.dart';
import 'package:vockify/src/pages/tour/tour_page.dart';
import 'package:vockify/src/services/app_storage/app_storage.dart';
import 'package:vockify/src/services/app_storage/app_storage_key.dart';
import 'package:vockify/src/widgets/common/loader.dart';
import 'package:vockify/src/widgets/home.dart';

class InitialWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InitialState();
}

class _InitialState extends State<InitialWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoaderWidget(),
    );
  }

  @override
  void initState() {
    _navigate();
    super.initState();
  }

  Future<void> _navigate() async {
    final bool isTourFinished = await AppStorage.getInstance()
            ?.containsKey(AppStorageKey.isTourFinished) ??
        false;

    if (!isTourFinished) {
      scheduleMicrotask(() {
        Navigator.of(NavigatorHolder.navigatorKey.currentContext!)
            .pushReplacement(
          MaterialPageRoute<TourPageWidget>(
            builder: (context) {
              return TourPageWidget();
            },
          ),
        );
      });
    } else {
      Navigator.of(NavigatorHolder.navigatorKey.currentContext!)
          .pushReplacement(
        MaterialPageRoute<HomeWidget>(
          builder: (context) {
            return HomeWidget();
          },
        ),
      );
    }
  }
}
