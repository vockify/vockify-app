import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:vockify/src/api/dto/auth_user_response.dart';
import 'package:vockify/src/api/dto/set_dto.dart';
import 'package:vockify/src/api/dto/set_response.dart';
import 'package:vockify/src/api/dto/sets_response.dart';
import 'package:vockify/src/api/dto/terms_response.dart';
import 'package:vockify/src/api/http_codes.dart';
import 'package:vockify/src/redux/actions/unauthorize_action.dart';
import 'package:vockify/src/services/app_storage.dart';

AppApi api;

void setupApi(Store store) {
  api = AppApi(store);
}

class AppApi {
  static const apiUrl = 'https://vockify.website/api';

  final Store store;

  AppApi(this.store);

  Future<SetResponse> addSet(SetDto requestData) async {
    final data = await _post('/sets/', requestData.toJson());
    return SetResponse.fromJson(data);
  }

  Future<AuthUserResponse> authUser() async {
    final data = await _get('/auth/user');
    return data == null ? null : AuthUserResponse.fromJson(data);
  }

  Future<void> deleteSet(int id) async {
    await _delete('/sets/$id');
  }

  Future<SetsResponse> getSets() async {
    final data = await _get('/sets/');
    return SetsResponse.fromJson(data);
  }

  Future<TermsResponse> getSetTerms(int setId) async {
    final data = await _get('/sets/$setId/terms');
    return TermsResponse.fromJson(data);
  }

  Future<Map<String, dynamic>> _delete(String url) async {
    final headers = await _getHeaders();

    final response = await http.delete(
      '$apiUrl$url',
      headers: headers,
    );

    return _processResponse(response);
  }

  Future<Map<String, dynamic>> _get(String url) async {
    final headers = await _getHeaders();

    try {
      final response = await http.get(
        '$apiUrl$url',
        headers: headers,
      );
      return _processResponse(response);
    } on http.ClientException catch (e) {
      store.dispatch(UnauthorizeAction());
      rethrow;
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    final storage = AppStorage.getInstance();
    final token = await storage.getValue('token') ?? '';

    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
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
