import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/constrains.dart';

class AddToWatchListApi{

  Future<void> addToWatchlist(String accountId, String sessionId, int movieId) async {
    final Uri uri = Uri.parse('${Constrains.baseUrl}/account/$accountId/watchlist')
        .replace(queryParameters: {
      'api_key': Constrains.apiKey,
      'session_id': sessionId,
    });

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json;charset=utf-8'},
      body: jsonEncode({
        'media_type': 'movie',
        'media_id': movieId,
        'watchlist': true,
      }),
    );

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to add movie to watchlist');
    }
  }

}

