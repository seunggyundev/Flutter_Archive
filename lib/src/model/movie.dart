class Movie {
  String? overview;
  String? posterPath;
  String? title;
  Movie({this.overview, this.posterPath, this.title,});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        overview: json["overview"] as String,
        posterPath: json["poster_path"] as String,
        title: json["title"] as String
    );
  }
}