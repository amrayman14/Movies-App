import 'package:flutter/material.dart';

import '../constrains.dart';
import '../screens/movie_detailed_screen.dart';

class UpcomingMoviesWidget extends StatelessWidget {
  const UpcomingMoviesWidget({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.infinity,
      child: ListView.builder(
        itemCount: snapshot.data.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 180,
                  width: 150,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) =>
                              MovieDetailed(movie: snapshot.data[index],),
                        ),
                      );
                    },
                    child: Image.network(
                      "${Constrains.baseImageUrl}${snapshot.data[index].posterPath}",
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6,),
              Text(snapshot.data[index].title)
            ],
          ),
        ),
      ),
    );
  }
}
