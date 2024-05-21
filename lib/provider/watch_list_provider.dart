import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/account/whatch_list/get_watch_list.dart';
import '../models/movie.dart';


class WatchListNotifier extends StateNotifier<List<Movie>> {
  WatchListNotifier() : super([]);

  void setWatchList(String accountId ,String sessionId) async {
    state =  await GetWatchList().getWatchlist(accountId, sessionId);
  }

  void removeFromWatchListProvider(Movie movie)  {

      state = state.where((m) => m.id != movie.id).toList();

  }
  void addToWatchListProvider(Movie movie)  {

      state = [...state, movie];

  }

}

final watchListProvider = StateNotifierProvider<WatchListNotifier, List<Movie>>((ref) {
  return WatchListNotifier();
});