import 'package:flutflix/colors.dart';
import 'package:flutflix/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'details_screen.dart';

class FavoriteScreen extends StatelessWidget {
  static const String routeName = 'favorite';
  FavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    final movieList = provider.favoriteMovies;
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_rounded,
              color: AppColors.secondaryColor,
              size: 30,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Favorites',
                textAlign: TextAlign.center,
                style: GoogleFonts.creepster(
                  color: AppColors.secondaryColor,
                  fontSize: 30,
                ),
              ),
              Icon(
                Icons.favorite,
                size: 30,
                color: AppColors.secondaryColor,
              )
            ],
          ),
        ),
        body: ListView.builder(
            itemCount: movieList.length,
            itemBuilder: (context, index) {
              final movie = movieList[index];
              return Column(
                children: [
                  SizedBox(
                    height: 22,
                  ),
                  InkWell(
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
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              height: 250,
                              width: 200,
                              child: Image.network(
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                                '${Constants.imagePath}${movieList[index].posterPath}',
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                movie.title ?? '',
                                style: GoogleFonts.creepster(
                                    color: AppColors.secondaryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                              IconButton(
                                onPressed: () {
                                  //////////////////////////////////////////////////////
                                  provider.toggleFavorite(movie);
                                },
                                icon: provider.isExist(movie)
                                    ? Icon(Icons.favorite,
                                    color: AppColors.secondaryColor)
                                    : Icon(
                                  Icons.favorite_border,
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }));
  }
}
