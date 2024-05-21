import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/api/account/whatch_list/add_to_watch_list.dart';
import 'package:movies_app/api/account/whatch_list/remove_from_watch_list.dart';
import 'package:movies_app/colors.dart';
import 'package:movies_app/provider/watch_list_provider.dart';

import '../constrains.dart';
import '../models/movie.dart';
import '../provider/account_id_provider.dart';
import '../provider/session_id_provider.dart';

class MovieDetailed extends ConsumerStatefulWidget {
  const MovieDetailed({super.key, required this.movie});
  final Movie movie;
  @override
  ConsumerState<MovieDetailed> createState() {
    return _MovieDetailed();
  }
}

class _MovieDetailed extends ConsumerState<MovieDetailed> {

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final sessionId = ref.read(sessionIdProvider);
    final accountId = ref.read(accountIdProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  color: Colours.scaffoldBgColor,
                  borderRadius: BorderRadius.circular(8)),
              margin: const EdgeInsets.only(top: 16, left: 16),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (accountId != null && sessionId != null) {
                    ref
                        .read(watchListProvider.notifier)
                        .setWatchList(accountId, sessionId);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ),
            actions: [
              if (sessionId != null)
                IconButton(
                    onPressed: () async {
                      setState(() {
                        final existWatchList = ref.watch(watchListProvider);
                        if (existWatchList.contains(widget.movie)) {
                          RemoveFromWatchList().removeFromWatchlist(
                              accountId!, sessionId, widget.movie.id);
                          ref.read(watchListProvider.notifier).removeFromWatchListProvider(widget.movie);
                          _showMessage('Movie removed from Watch List');
                        } else {
                          AddToWatchListApi().addToWatchlist(
                              accountId!, sessionId, widget.movie.id);
                          ref.read(watchListProvider.notifier).addToWatchListProvider(widget.movie);
                          _showMessage('Movie added to Watch List');
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.bookmark ,
                      color: Colors.red,
                      size: 40,
                    )),
            ],
            backgroundColor: Colours.scaffoldBgColor,
            pinned: true,
            expandedHeight: 500,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "${Constrains.baseImageUrl}${widget.movie.posterPath}",
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    style: GoogleFonts.aBeeZee(
                        fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Text(
                      "Overview",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 26, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.movie.overview,
                    style: GoogleFonts.aBeeZee(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                          "Release date : ${widget.movie.releaseDate}",
                          style: GoogleFonts.aBeeZee(fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Rate ",
                              style: GoogleFonts.aBeeZee(fontSize: 14),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amberAccent,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "${widget.movie.voteAverage.toStringAsFixed(1)}/10",
                              style: GoogleFonts.aBeeZee(fontSize: 14),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
