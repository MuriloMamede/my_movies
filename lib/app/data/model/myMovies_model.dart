import 'dart:convert';
import 'package:my_movies/app/data/model/movie_model.dart';
import 'package:my_movies/app/global/constants.dart';

class MyMovie {
  final String posterPath;
  int id;
  final String title;
  bool isWatched;
  int idProfile;

  MyMovie(
      {this.posterPath, this.id, this.title, this.isWatched, this.idProfile});

  factory MyMovie.fromJson(String str) => MyMovie.fromMap(json.decode(str));

  factory MyMovie.fromMap(Map<String, dynamic> json) => MyMovie(
        posterPath: json[MYMOVIES_POSTERPATH],
        id: json[MYMOVIES_ID],
        title: json[MYMOVIES_TITLE],
        isWatched: json[MYMOVIES_ISWATCHED] == 0 ? false : true,
        idProfile: json[MYMOVIES_ID_PROFILE],
      );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      MYMOVIES_ID_PROFILE: this.idProfile,
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
