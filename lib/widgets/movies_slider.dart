import 'package:flutflix/constants.dart';
import 'package:flutflix/screens/details_screen.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';

class MoviesSlider extends StatelessWidget {
  final List<Movie> movieList;
  const MoviesSlider({Key? key, required this.movieList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      movie: movieList[index],
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 200,
                  width: 150,
                  child: Image.network(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      '${Constants.imagePath}${movieList[index].posterPath}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
