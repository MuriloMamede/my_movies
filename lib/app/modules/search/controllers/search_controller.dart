import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies/app/data/model/movie_model.dart';

import 'package:my_movies/app/data/repository/movie_repository.dart';
import 'package:my_movies/app/data/repository/myMovies_repository.dart';

class SearchController extends GetxController {
  final MovieRepository repository = MovieRepository();
  final MyMoviesRepository _myMoviesRepository = MyMoviesRepository();

  var movies = <Movie>[].obs;

  void searchMovie(String query) async {
    if (query != null) {
      if (query.length > 3) {
        movies.assignAll(await repository.searchMovie(query));
      }
    }
  }

  void addtoMyList(int index) async {
    //  movies[index].
    try {
      await _myMoviesRepository.add(movies[index]);
      Get.defaultDialog(title: 'Sucesso', content: Text('Filme adicionado'));
    } catch (e) {
      if (e.getResultCode() == 1555) {
        Get.defaultDialog(
            title: 'Ops...', content: Text('Filme já adicionada na lista'));
      } else {
        Get.defaultDialog(
            title: 'Ops',
            content: Text('Error: ' + e.getResultCode().toString()));
      }
    }
  }
}
