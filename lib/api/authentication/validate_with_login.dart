import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/constrains.dart';

class ValidateWithLogin {


  Future<void> validateWithLogin(String requestToken, String username, String password) async {
    final response = await http.post(
      Uri.parse(
          '${Constrains.baseUrl}${Constrains.validateWithLoginEndpoint}?api_key=${Constrains.apiKey}'),
      body: jsonEncode({
        'username': username,
        'password': password,
        'request_token': requestToken,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }


}
