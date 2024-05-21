import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

import '../constrains.dart';
import '../models/movie.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key, required this.movie, required this.selectedMovie});

  final Movie movie;
  final void Function(Movie movie) selectedMovie;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          selectedMovie(movie);
        },
        child: Stack(
          children: [
            Hero(
              tag: movie.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(
                    '${Constrains.baseImageUrl}${movie.posterPath}'),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      movie.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text(
                            "Release date : ${movie.releaseDate}",
                            style: GoogleFonts.aBeeZee(fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Rate ",
                                style: GoogleFonts.aBeeZee(fontSize: 12),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.amberAccent,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                "${movie.voteAverage.toStringAsFixed(1)}/10",
                                style: GoogleFonts.aBeeZee(fontSize: 12),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
