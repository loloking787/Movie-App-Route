import 'package:flutter/material.dart';
import '../models/movie.dart';




class FavoriteProvider extends ChangeNotifier{
   List<Movie> favoriteMovies = [];
   List<Movie> get movie => favoriteMovies ;

   void toggleFavorite(Movie movie){
     final isExist = favoriteMovies.contains(movie);
     if(isExist){
       favoriteMovies.remove(movie);
     }else{
       favoriteMovies.add(movie);
     }
     notifyListeners();
   }

   bool isExist(Movie movie){
     final isExist = favoriteMovies.contains(movie);
     return isExist;
   }

   void clearFavorite(){
     favoriteMovies = [];
     notifyListeners();
   }
}