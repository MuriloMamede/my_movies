import 'dart:convert';
import 'package:my_movies/app/global/constants.dart';

class Movie {
  final String posterPath;
  int id;
  final String title;
  bool isWatched;
  int idProfile;
  int idTMDB;

  Movie(
      {this.posterPath,
      this.idTMDB,
      this.title,
      this.isWatched,
      this.idProfile,
      this.id});

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
        idProfile: json[MYMOVIES_ID_PROFILE],
        idTMDB: json[MYMOVIES_ID_TMDB],
      );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      MYMOVIES_ID_TMDB: this.idTMDB,
      MYMOVIES_ID_PROFILE: this.idProfile,
      MYMOVIES_POSTERPATH: this.posterPath,
      MYMOVIES_ID: this.id,
      MYMOVIES_TITLE: this.title,
      MYMOVIES_ISWATCHED: isWatched == true ? 1 : 0,
    };
    print(map);

    if (id != null) {
      map[MYMOVIES_ID] = this.id;
    }

    return map;
  }
}
