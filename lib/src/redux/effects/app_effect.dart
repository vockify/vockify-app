import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:redux_epics/redux_epics.dart';
import 'package:vockify/src/models/model.dart';
import 'package:vockify/src/redux/actions/authorize_action.dart';
import 'package:vockify/src/redux/actions/load_data_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AppEffect {
  Epic<AppState> getEffects() {
    return combineEpics([
      TypedEpic<AppState, AuthorizeAction>(_onAuthorizeAction),
      TypedEpic<AppState, LoadDataAction>(_onLoadDataAction),
    ]);
  }

  Stream<Object> _onLoadDataAction(
      Stream<LoadDataAction> actions,
      EpicStore<AppState> store,
      ) async* {
    await for (final action in actions) {
      final response = await http.get('https://reqres.in/api/users?page=2');

      if (response.statusCode == 200) {
        final model = Model.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    }
  }

  Stream<Object> _onAuthorizeAction(
    Stream<AuthorizeAction> actions,
    EpicStore<AppState> store,
  ) async* {
    await for (final action in actions) {
      final response = await http.get('https://reqres.in/api/users?page=2');

      if (response.statusCode == 200) {
        final model = Model.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load');
      }
    }
  }
}
