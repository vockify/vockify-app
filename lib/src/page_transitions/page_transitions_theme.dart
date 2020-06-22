import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vockify/src/page_transitions/web_page_transitions_builder.dart';

final pageTransitionsTheme = PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
  TargetPlatform.android: WebPageTransitionsBuilder(),
  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
  TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
  TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
});
