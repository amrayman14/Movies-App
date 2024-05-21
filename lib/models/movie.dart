class Movie{
  final String backdropPath;
  final int id;
  final String overview;
  final String posterPath;
  final String title;
  final String releaseDate;
  final double voteAverage;

  Movie({
    required this.backdropPath,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
});

  factory Movie.fromJson(Map<String , dynamic> movieData){
    return Movie(
        backdropPath: movieData["backdrop_path"],
        id: movieData["id"],
        overview: movieData["overview"],
        posterPath: movieData["poster_path"],
        title: movieData["title"],
        releaseDate: movieData["release_date"],
        voteAverage: movieData["vote_average"]
    );
  }

}

