import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vockify/src/api/dto/get_sets_response.dart';
import 'package:vockify/src/redux/actions/unauthorize_action.dart';

AppApi api;

void setupApi(Store store) {
  api = AppApi(store);
}

class AppApi {
  static const apiUrl = 'https://vockify.website/api';

  final Store store;

  AppApi(this.store);

  Future<GetSetsResponse> getSets() async {
    final data = await _get('/sets');
    return data == null ? null : GetSetsResponse.fromJson(data);
  }

  Future<Map<String, dynamic>> _get(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final response = await http.get(
      '$apiUrl$url',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 401) {
      store.dispatch(UnauthorizeAction());
      return null;
    } else if (response.statusCode != 200) {
      throw Error();
    }

    return json.decode(response.body);
  }
}
