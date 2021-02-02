import 'dart:convert';

class Movie {
  final int voteCount;

  final String posterPath;
  final int id;

  final String originalTitle;
  final List<int> genreIds;
  final String title;

  final String overview;
  final DateTime releaseDate;

  const Movie({
    this.voteCount,
    this.posterPath,
    this.id,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.overview,
    this.releaseDate,
  });

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        voteCount: json["vote_count"],
        posterPath: json["poster_path"],
        id: json["id"],
        originalTitle: json["original_title"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        title: json["title"],
        overview: json["overview"],
        releaseDate: DateTime.parse(json["release_date"]),
      );
}
