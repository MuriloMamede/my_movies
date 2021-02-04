import 'dart:convert';
import 'package:my_movies/app/global/constants.dart';

class Movie {
  final String posterPath;
  int id;
  final String title;
  bool isWatched;

  Movie({this.posterPath, this.id, this.title, this.isWatched});

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        posterPath: json["poster_path"],
        id: json["id"],
        title: json["title"],
        isWatched: false,
      );

  factory Movie.fromDBMap(Map<String, dynamic> json) => Movie(
        posterPath: json[MYMOVIES_POSTERPATH],
        id: json[MYMOVIES_ID],
        title: json[MYMOVIES_TITLE],
        isWatched: json[MYMOVIES_ISWATCHED] == 0 ? false : true,
      );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      MYMOVIES_POSTERPATH: this.posterPath,
      MYMOVIES_ID: this.id,
      MYMOVIES_TITLE: this.title,
      MYMOVIES_ISWATCHED: isWatched == true ? 1 : 0,
    };

    if (id != null) {
      map[MYMOVIES_ID] = this.id;
    }

    return map;
  }
}
