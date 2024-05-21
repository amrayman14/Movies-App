import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:movies_app/api/home_screen_data/get_now_playing_api.dart';
import 'package:movies_app/api/home_screen_data/get_top_rated_api.dart';
import 'package:movies_app/api/home_screen_data/get_upcoming_api.dart';
import 'package:movies_app/screens/auth_screen.dart';
import 'package:movies_app/widgets/top_movies_widget.dart';
import 'package:movies_app/widgets/now_playing_slider.dart';
import 'package:movies_app/widgets/upcoming_movies_widget.dart';
import '../models/movie.dart';
import '../provider/session_id_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<List<Movie>> nowPlayingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;
  @override
  void initState() {
    super.initState();
    nowPlayingMovies = NowPlayingMovies().getNowPlayingMovies();
    topRatedMovies = TopMoviesApi().getTopRatedMovies();
    upcomingMovies = UpcomingApi().getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    final sessionId = ref.read(sessionIdProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/images/movies_logo.png',
          fit: BoxFit.cover,
          height: 30,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
        actions: [
          if (sessionId != null)
            IconButton(
                onPressed: () {
                  ref.read(sessionIdProvider.notifier).clearSessionId();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => const AuthScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 30,
                )),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Now Playing',
                  style: GoogleFonts.aBeeZee(fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              FutureBuilder(
                  future: nowPlayingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.hasData) {
                      return TrendingWidget(snapshot: snapshot,);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Top rated movies',
                style: GoogleFonts.aBeeZee(fontSize: 25),
              ),
              const SizedBox(
                height: 16,
              ),
              FutureBuilder(
                  future: topRatedMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.hasData) {
                      return TopMoviesWidget(snapshot: snapshot,);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Upcoming movies',
                style: GoogleFonts.aBeeZee(fontSize: 25),
              ),
              const SizedBox(
                height: 16,
              ),
              FutureBuilder(
                  future: upcomingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else if (snapshot.hasData) {
                      return UpcomingMoviesWidget(snapshot: snapshot,);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
