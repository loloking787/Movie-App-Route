import 'package:flutflix/api/api.dart';
import 'package:flutflix/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/trending_slider_widget.dart';

class SearchScreen extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => showResults(context),
        icon: const Icon(
          Icons.search,
          size: 25,
          color: AppColors.secondaryColor,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(
        Icons.close,
        size: 25,
        color: AppColors.secondaryColor,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FutureBuilder(
          future: Api.searchMovie(searchKeyword: query),
          builder: (context, movie) {
            if (movie.data?.isEmpty ?? false) {
              return Center(
                child: Text(
                  'Result Not Found',
                  style: GoogleFonts.creepster(color: AppColors.secondaryColor,fontSize: 25),
                ),
              );
            } else if (movie.hasError) {
              return Center(
                child: Text(movie.error.toString()),
              );
            } else if (movie.hasData) {
              return TrendingSlider(
                movieList: movie.data ?? [],
              );
            } else {
              return const CircularProgressIndicator(
                color: AppColors.secondaryColor,
              );
            }
          },
        ),
        Text(
          'Pick Your Movie',
          style: GoogleFonts.creepster(
              fontSize: 30, color: AppColors.secondaryColor),
        )
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FutureBuilder(
          future: Api.getTrendingMovies(),
          builder: (context, movie) {
            if (movie.hasError) {
              return Center(
                child: Text(movie.error.toString()),
              );
            } else if (movie.hasData) {
              return TrendingSlider(
                movieList: movie.data ?? [],
              );
            } else {
              return const CircularProgressIndicator(
                color: AppColors.secondaryColor,
              );
            }
          },
        ),
        Text(
          'Pick Your Movie',
          style: GoogleFonts.creepster(
              fontSize: 30, color: AppColors.secondaryColor),
        )
      ],
    );
  }
}
