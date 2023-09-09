import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/database/data_service.dart';
import 'package:vockify/src/navigation/navigation_holder.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/app_router.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/initial.dart';

class VockifyApp extends StatelessWidget {
  final Store<AppState> store;

  VockifyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        navigatorKey: NavigatorHolder.navigatorKey,
        onGenerateRoute: AppRouter.getRoute,
        onGenerateInitialRoutes: _getInitialRoutes,
        title: 'Vockify',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: VockifyColors.primary),
          primaryColor: VockifyColors.primary,
          primarySwatch: VockifyColors.primary,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }

  List<Route> _getInitialRoutes(String route) {
    // return [
    //   MaterialPageRoute(builder: (context) => DriftDbViewer(dataService.database)),
    // ];

    return [
      AppRouter.buildRoute(
        RouteSettings(name: Routes.app),
        InitialWidget(
          route: Routes.home,
        ),
      ),
    ];
  }
}
