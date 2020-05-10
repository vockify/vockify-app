import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vockify/src/api/dto/set_dto.dart';
import 'package:vockify/src/api/dto/set_response.dart';
import 'package:vockify/src/api/dto/sets_response.dart';
import 'package:vockify/src/api/http_codes.dart';
import 'package:vockify/src/redux/actions/unauthorize_action.dart';

AppApi api;

void setupApi(Store store) {
  api = AppApi(store);
}

class AppApi {
  static const apiUrl = 'https://vockify.website/api';

  final Store store;

  AppApi(this.store);

  Future<SetsResponse> getSets() async {
    final data = await _get('/sets');
    return SetsResponse.fromJson(data);
  }

  Future<SetResponse> addSet(SetDto requestData) async {
    final data = await _post('/sets/', requestData.toJson());
    return SetResponse.fromJson(data);
  }

  Future<void> deleteSet(int id) async {
    await _delete('/sets/$id');
  }

  Future<Map<String, dynamic>> _get(String url) async {
    final response = await http.get(
      '$apiUrl$url',
      headers: await _getHeaders(),
    );

    return _processResponse(response);
  }

  Future<Map<String, dynamic>> _post(String url, dynamic body) async {
    final headers = await _getHeaders();
    final response = await http.post(
      '$apiUrl$url',
      body: jsonEncode(body),
      headers: headers,
    );

    return _processResponse(response);
  }

  Future<Map<String, dynamic>> _delete(String url) async {
    final headers = await _getHeaders();

    final response = await http.delete(
      '$apiUrl$url',
      headers: headers,
    );

    return _processResponse(response);
  }

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode == HttpCodes.UNAUTHORIZED) {
      store.dispatch(UnauthorizeAction());
      throw Error();
    }

    if (response.statusCode > HttpCodes.BAD_REQUEST) {
      throw Error();
    }

    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    }

    return {};
  }
}
