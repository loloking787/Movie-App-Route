class Movie {
  String? title;
  String? originalTitle;
  String? overView;
  String? posterPath;
  String? releaseDate;
  double? voteAverage;

  Movie({
    required this.title,
    required this.originalTitle,
    required this.overView,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json["title"],
        originalTitle: json["original_title"],
        overView: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        voteAverage: json["vote_average"].toDouble(),
    );
  }
}
