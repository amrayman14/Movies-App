import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/screens/movie_detailed_screen.dart';
import 'package:movies_app/widgets/movie.dart';

import '../models/movie.dart';
import '../provider/watch_list_provider.dart';


class WatchList extends ConsumerStatefulWidget {
  const WatchList({
    super.key,
    this.title,
    required this.sessionId,
    required this.accountId,
  });

  final String? title ;
  final String sessionId;
  final String accountId;

  @override
  ConsumerState<WatchList> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends ConsumerState<WatchList> {

  void _onSelectedMovie(Movie movie, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) =>
            MovieDetailed(
              movie: movie,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   var movies = ref.watch(watchListProvider);
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            " There is nothing here",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Try selecting different category",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ],
      ),
    );

      content = ListView.builder(
        itemCount: movies.length,
        itemBuilder: (ctx, index) => MovieItem(
          movie : movies[index],
          selectedMovie: (movie) {
            _onSelectedMovie(movie, context);
          },
        ),
      );

    if (widget.title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: content,
    );
  }
}
