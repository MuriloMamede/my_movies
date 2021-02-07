import 'dart:convert';
import 'package:my_movies/app/global/constants.dart';

class Movie {
  final String posterPath;
  int id;
  final String title;
  bool isWatched;
  int idProfile;
  List<int> listGenresId;
  String genresId;

  Movie(
      {this.posterPath,
      this.title,
      this.isWatched,
      this.idProfile,
      this.id,
      this.listGenresId,
      this.genresId});

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        posterPath: json["poster_path"],
        id: json["id"],
        title: json["title"],
        isWatched: false,
        listGenresId: List<int>.from(json["genre_ids"].map((x) => x)),
      );

  factory Movie.fromDBMap(Map<String, dynamic> json) => Movie(
        posterPath: json[MYMOVIES_POSTERPATH],
        id: json[MYMOVIES_ID],
        title: json[MYMOVIES_TITLE],
        isWatched: json[MYMOVIES_ISWATCHED] == 0 ? false : true,
        idProfile: json[MYMOVIES_ID_PROFILE],
        genresId: json[MYMOVIES_GENRES_ID],
      );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      MYMOVIES_ID_PROFILE: this.idProfile,
      MYMOVIES_POSTERPATH: this.posterPath,
      MYMOVIES_ID: this.id,
      MYMOVIES_TITLE: this.title,
      MYMOVIES_ISWATCHED: isWatched == true ? 1 : 0,
      MYMOVIES_GENRES_ID: getGenresIds(this.listGenresId),
    };

    if (id != null) {
      map[MYMOVIES_ID] = this.id;
    }

    return map;
  }

  String getGenresIds(List<int> listGenresId) {
    String genresId = '';
    if (listGenresId != null) {
      for (var i = 0; i < listGenresId.length; i++) {
        if (listGenresId.length == 1) {
          genresId += listGenresId[i].toString();
        } else {
          if (i == listGenresId.length - 1) {
            genresId += listGenresId[i].toString();
          } else
            genresId += listGenresId[i].toString() + ',';
        }
      }
    }
    return genresId;
  }
}
