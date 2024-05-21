import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constrains.dart';

class CreateSession {

  Future<String> createSession(String requestToken) async {
    final response = await http.post(
      Uri.parse(
          '${Constrains.baseUrl}${Constrains.createNewSessionEndpoint}?api_key=${Constrains.apiKey}'),
      body: jsonEncode({'request_token': requestToken}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['session_id']);
      return data['session_id'];
    } else {
      throw Exception('Failed to create session');
    }
  }
}
