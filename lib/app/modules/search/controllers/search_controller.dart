import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_movies/app/data/model/movie_model.dart';

import 'package:my_movies/app/data/repository/movie_repository.dart';

class SearchController extends GetxController {
  final MovieRepository repository = MovieRepository();

  var movies = <Movie>[].obs;

  void searchMovie(String query) async {
    if (query != null) {
      if (query.length > 3) {
        movies.assignAll(await repository.searchMovie(query));
      }
    }
  }

  /*void loadData() async {
    movies.assignAll(await repository.getPopular());
  }*/
}
