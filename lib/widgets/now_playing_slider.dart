import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/constrains.dart';
import 'package:movies_app/screens/movie_detailed_screen.dart';

class TrendingWidget extends StatelessWidget {
  const TrendingWidget({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: snapshot.data.length,
      options: CarouselOptions(
          height: MediaQuery.sizeOf(context).height * .50,
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          viewportFraction: .55,
          enlargeCenterPage: true,
          pageSnapping: true),
      itemBuilder: (context, itemIndex, pageIndex) => Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * .33,
              width: 200,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) =>
                          MovieDetailed(movie: snapshot.data[itemIndex]),
                    ),
                  );
                },
                child: Stack(children: [
                  Image.network(
                    "${Constrains.baseImageUrl}${snapshot.data[itemIndex].posterPath}",
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      color: Colors.black54,
                      child: Column(
                        children: [
                          Text('${snapshot.data[itemIndex].title}'),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            '${itemIndex + 1} /20',
                            style: GoogleFonts.aBeeZee(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
