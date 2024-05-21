import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/movie.dart';

import '../../constrains.dart';

class UpcomingApi{

  final _upcomingUrl =
      "${Constrains.baseUrl}${Constrains.upcomingEndpoint}?api_key=${Constrains.apiKey}";

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(_upcomingUrl));
    if(response.statusCode == 200){
      final decodedData = json.decode(response.body)["results"] as List;
      return decodedData.map((m) => Movie.fromJson(m)).toList();
    }
    else{
      throw Exception("Error getting the data");
    }
  }
}