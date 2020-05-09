import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vockify/src/api/dto/get_sets_response.dart';

class AppApi {
  static const apiUrl = 'https://vockify.website/api';

  Future<GetSetsResponse> getSets() async {
    final data = await _get('/sets');
    return GetSetsResponse.fromJson(data);
  }

  Future<Map<String, dynamic>> _get(String url) async {
    final response = await http.get(
      '$apiUrl$url',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Error();
    }

    return json.decode(response.body);
  }
}
