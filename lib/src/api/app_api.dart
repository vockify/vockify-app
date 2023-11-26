import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:vockify/src/api/dto/spell_check/spell_check_dto.dart';
import 'package:vockify/src/api/dto/spell_check/spell_check_request_dto.dart';
import 'package:vockify/src/api/dto/translate/translate_request_dto.dart';
import 'package:vockify/src/api/dto/translate/translate_response.dart';
import 'package:vockify/src/api/http_codes.dart';
import 'package:vockify/src/redux/state/app_state.dart';

late AppApi api;

void setupApi(Store<AppState> store) {
  api = AppApi(store);
}

class AppApi {
  static const apiUri = 'vockify.mikedanagam.space';
  static const yandexSpellCheckUri = 'speller.yandex.net';

  final Store<AppState> store;

  AppApi(this.store);

  Future<TranslateResponse> translate(TranslateRequestDto requestDto) async {
    final data = await _post('/translate/', requestDto);
    return TranslateResponse.fromJson(data);
  }

  Future<Iterable<SpellCheckDto>> spellCheck(SpellCheckRequestDto requestDto) async {
    final response = await http.get(Uri.https(
      yandexSpellCheckUri,
      '/services/spellservice.json/checkText',
      _convertQueryParameters(requestDto.toJson()),
    ));

    final jsonMap = json.decode(response.body) as List;

    return jsonMap.map((e) => SpellCheckDto.fromJson(e as Map<String, dynamic>));
  }

  Map<String, String> _convertQueryParameters(Map<String, dynamic> queryParameters) =>
      queryParameters.map((key, value) => MapEntry(key, value.toString())).cast<String, String>();

  Future<Map<String, String>> _getHeaders() async {
    return <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
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
      // store.dispatch(UnauthorizeAction());
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
}
