import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/constrains.dart';

class RequestToken {


  Future<String> requestToken() async {
    final response = await http.get(Uri.parse(
        '${Constrains.baseUrl}${Constrains.requestTokenEndpoint}?api_key=${Constrains.apiKey}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['request_token'];
    } else {
      throw Exception('Failed to request token');
    }
  }

}