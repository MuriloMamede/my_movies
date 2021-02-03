import 'dart:convert';

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
      );

  factory Movie.fromDBMap(Map<String, dynamic> json) => Movie(
        posterPath: json["posterPath"],
        id: json["id"],
        title: json["title"],
        isWatched: json["isWatched"] == 0 ? true : false,
      );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'posterPath': this.posterPath,
      'id': this.id,
      'title': this.title,
      'isWatched': 0
    };

    if (id != null) {
      map['id'] = this.id;
    }

    return map;
  }
}
