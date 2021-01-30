import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:vockify/src/api/dto/auth/register_response.dart';
import 'package:vockify/src/api/dto/auth/user_response.dart';
import 'package:vockify/src/api/dto/sets/set_dto.dart';
import 'package:vockify/src/api/dto/sets/set_filters_dto.dart';
import 'package:vockify/src/api/dto/sets/set_response.dart';
import 'package:vockify/src/api/dto/sets/sets_response.dart';
import 'package:vockify/src/api/dto/terms/term_dto.dart';
import 'package:vockify/src/api/dto/terms/term_filters_dto.dart';
import 'package:vockify/src/api/dto/terms/term_response.dart';
import 'package:vockify/src/api/dto/terms/terms_response.dart';
import 'package:vockify/src/api/dto/translate/translate_request_dto.dart';
import 'package:vockify/src/api/dto/translate/translate_response.dart';
import 'package:vockify/src/api/http_codes.dart';
import 'package:vockify/src/redux/actions/auth/unauthorize_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';

AppApi api;

void setupApi(Store<AppState> store) {
  api = AppApi(store);
}

class AppApi {
  static const apiUri = 'api.vockify.website';
  static const publicUserId = 18;

  final Store<AppState> store;

  AppApi(this.store);

  Future<RegisterResponse> register() async {
    final data = await _post('/auth/register');
    return data == null ? null : RegisterResponse.fromJson(data);
  }

  Future<SetResponse> addSet(SetDto requestData) async {
    final data = await _post('/sets/', requestData.toJson());
    return SetResponse.fromJson(data);
  }

  Future<TermResponse> addTerm(TermDto requestData) async {
    final data = await _post('/terms/', requestData.toJson());
    return TermResponse.fromJson(data);
  }

  Future<UserResponse> getUser() async {
    final data = await _get('/auth/user');
    return data == null ? null : UserResponse.fromJson(data);
  }

  Future<SetResponse> copySet(int id) async {
    final data = await _post('/sets/$id/copy');
    return SetResponse.fromJson(data);
  }

  Future<void> deleteSet(int id) async {
    await _delete('/sets/$id');
  }

  Future<void> deleteTerm(int id) async {
    await _delete('/terms/$id');
  }

  Future<SetsResponse> getSets(SetFiltersDto filters) async {
    final data = await _get('/sets', filters.toJson());
    return SetsResponse.fromJson(data);
  }

  Future<TermsResponse> getTerms(TermFiltersDto filters) async {
    final data = await _get('/terms', filters.toJson());
    return TermsResponse.fromJson(data);
  }

  Future<TranslateResponse> translate(TranslateRequestDto requestDto) async {
    final data = await _post('/translate/', requestDto);
    return TranslateResponse.fromJson(data);
  }

  Future<SetResponse> updateSet(int id, SetDto requestData) async {
    final data = await _put('/sets/$id', requestData.toJson());
    return SetResponse.fromJson(data);
  }

  Future<TermResponse> updateTerm(int id, TermDto requestData) async {
    final data = await _put('/terms/$id', requestData.toJson());
    return TermResponse.fromJson(data);
  }

  Future<Map<String, dynamic>> _delete(String url) async {
    final headers = await _getHeaders();

    final response = await http.delete(
      Uri.http(apiUri, url),
      headers: headers,
    );

    return _processResponse(response);
  }

  Future<Map<String, dynamic>> _get(String url, [Map<String, dynamic> queryParameters = const {}]) async {
    final headers = await _getHeaders();

    try {
      final response = await http.get(
        Uri.http(apiUri, url, queryParameters.map((key, value) => MapEntry(key, value.toString())).cast<String, String>()),
        headers: headers,
      );
      return _processResponse(response);
    } on http.ClientException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    return <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authToken(store.state)}',
    };
  }

  Future<Map<String, dynamic>> _post(String url, [dynamic body]) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.http(apiUri, url),
      body: body != null ? jsonEncode(body) : null,
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
      return json.decode(response.body) as Map<String, dynamic>;
    }

    return {};
  }

  Future<Map<String, dynamic>> _put(String url, dynamic body) async {
    final headers = await _getHeaders();
    final response = await http.put(
      Uri.http(apiUri, url),
      body: jsonEncode(body),
      headers: headers,
    );

    return _processResponse(response);
  }
}
