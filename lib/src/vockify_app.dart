import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vockify/src/models/app_model.dart';
import 'package:vockify/src/models/bar_model.dart';
import 'package:vockify/src/navigation/navigation_holder.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/initial.dart';

class VockifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            final model = AppModel();
            model.init();
            return model;
          },
        ),
        ChangeNotifierProvider(
          create: (context) => BarModel(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: NavigatorHolder.navigatorKey,
        home: InitialWidget(),
        title: 'Vockify',
        theme: ThemeData(
          fontFamily: 'Raleway',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: VockifyColors.primary,
          ),
          primaryColor: VockifyColors.primary,
          primarySwatch: VockifyColors.primary,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
