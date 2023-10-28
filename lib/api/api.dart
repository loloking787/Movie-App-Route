import 'dart:convert';
import 'package:flutflix/constants.dart';
import 'package:flutflix/models/movie.dart';
import 'package:http/http.dart' as http;

class Api {
  static const trendingUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';
  static const topRatedUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}';
  static const upComingUrl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}';
  static const searchUrl =
      'https://api.themoviedb.org/3/search/movie?api_key=${Constants.apiKey}';

  static Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(trendingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something Happened');
    }
  }

  static Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(topRatedUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something Happened');
    }
  }

  static Future<List<Movie>> getUpComingMovies() async {
    final response = await http.get(Uri.parse(upComingUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something Happened');
    }
  }

  //https://api.themoviedb.org/3/search/movie
  static Future<List<Movie>> searchMovie({String? searchKeyword}) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?query=$searchKeyword&api_key=${Constants.apiKey}'));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Something Happened');
    }
  }

  // // https://api.themoviedb.org/3/search/movie?query=eq
  // static const String baseUrl = 'api.themoviedb.org';
  // static Future<List<Movie>> searchOa({required String searchKeyword}) async {
  //   var url = Uri.https(baseUrl, '/3/search/movie', {
  //     "apiKey": Constants.apiKey,
  //     "query": searchKeyword,
  //   });
  //   try {
  //     var response = await http.get(url);
  //     var bodyString = response.body;
  //     var json = jsonDecode(bodyString);
  //     var moviesResponse = Movie.fromJson(json);
  //     return moviesResponse as List<Movie>;
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
