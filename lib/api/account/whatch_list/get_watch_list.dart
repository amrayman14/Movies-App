import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/constrains.dart';

import '../../../models/movie.dart';

class GetWatchList{
  Future<List<Movie>> getWatchlist(String accountId, String sessionId) async {
    final Uri uri = Uri.parse('${Constrains.baseUrl}/account/$accountId/watchlist/movies').replace(queryParameters: {
      'api_key': Constrains.apiKey,
      'session_id': sessionId,
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to fetch watchlist');
    }
  }

}

