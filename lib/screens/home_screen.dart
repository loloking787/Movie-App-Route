import 'package:flutflix/api/api.dart';
import 'package:flutflix/colors.dart';
import 'package:flutflix/models/movie.dart';
import 'package:flutflix/screens/favorite_screen.dart';
import 'package:flutflix/screens/search_screen.dart';
import 'package:flutflix/widgets/movies_slider.dart';
import 'package:flutflix/widgets/trending_slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upComingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api.getTrendingMovies();
    topRatedMovies = Api.getTopRatedMovies();
    upComingMovies = Api.getUpComingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pushNamed(context, FavoriteScreen.routeName);
          },
          icon: Icon(Icons.favorite,
            color: AppColors.secondaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/route.png',
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: ()=> showSearch(context: context, delegate: SearchScreen()),
            child: Icon(Icons.search,
            color: AppColors.secondaryColor,
              size: 35,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trending Movies',
                style: GoogleFonts.creepster(
                    color: AppColors.secondaryColor, fontSize: 25),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                child: FutureBuilder(
                  future: trendingMovies,
                  builder: (context, movie) {
                    if (movie.hasError) {
                      return Center(
                        child: Text(movie.error.toString()),
                      );
                    }else if(movie.hasData){
                      return TrendingSlider(movieList: movie.data ?? [],);
                    }else{
                      return Container(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                'Top Rated Movies',
                style: GoogleFonts.creepster(
                    color: AppColors.secondaryColor, fontSize: 25),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                child: FutureBuilder(
                  future: topRatedMovies,
                  builder: (context, movie) {
                    if (movie.hasError) {
                      return Center(
                        child: Text(movie.error.toString()),
                      );
                    }else if(movie.hasData){
                      return MoviesSlider(movieList: movie.data ?? [],);
                    }else{
                      return Container(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                'Up Coming Movies',
                style: GoogleFonts.creepster(
                    color: AppColors.secondaryColor, fontSize: 25),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                child: FutureBuilder(
                  future: upComingMovies,
                  builder: (context, movie) {
                    if (movie.hasError) {
                      return Center(
                        child: Text(movie.error.toString()),
                      );
                    }else if(movie.hasData){
                      return MoviesSlider(movieList: movie.data ?? [],);
                    }else{
                      return Container(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
