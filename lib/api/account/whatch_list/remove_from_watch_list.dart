import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/constrains.dart';

class RemoveFromWatchList{
  Future<void> removeFromWatchlist(String accountId, String sessionId, int movieId) async {
    final Uri uri = Uri.parse('https://api.themoviedb.org/3/account/$accountId/watchlist')
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
        'watchlist': false,
      }),
    );

    if (response.statusCode == 200) {

    } else {

      throw Exception('Failed to remove movie from watchlist');
    }
  }
}
