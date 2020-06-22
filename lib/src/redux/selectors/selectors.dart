import 'package:vockify/src/redux/state/app_state.dart';

bool isLoading(AppState state, String key) => state.loading[key] ?? false;
