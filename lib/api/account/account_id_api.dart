import 'dart:convert';
import 'package:http/http.dart' as http;

class GetAccountId{
  Future<String> getAccountId(String apiKey, String sessionId) async {
    final response = await http.get(
      Uri.https('api.themoviedb.org', '/3/account', {
        'api_key': apiKey,
        'session_id': sessionId,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String accountId = data['id'].toString();
      return accountId;
    } else {
      throw Exception('Failed to retrieve account ID from TMDb API');
    }
  }
}

