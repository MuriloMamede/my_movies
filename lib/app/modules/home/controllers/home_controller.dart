import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies/app/data/model/movie_model.dart';

import 'package:my_movies/app/data/repository/movie_repository.dart';
import 'package:my_movies/app/data/repository/myMovies_repository.dart';

class HomeController extends GetxController {
  final MovieRepository _repository = MovieRepository();
  final MyMoviesRepository _myMoviesRepository = MyMoviesRepository();

  final moviesPopularList = <Movie>[].obs;
  var myMoviesList = <Movie>[].obs;

  void addtoMyList(int index) async {
    try {
      await _myMoviesRepository.add(moviesPopularList[index]);
      myMoviesList.add(moviesPopularList[index]);
    } catch (e) {
      if (e.getResultCode() == 1555) {
        Get.defaultDialog(
            title: 'Ops...', content: Text('Filme já adicionada na lista'));
      }

      print(e);
    }
  }

  void markAsWatched(index) async {
    Movie selectedMovie = myMoviesList[index];
    Movie movieUpdated = Movie(
        id: selectedMovie.id,
        isWatched: !selectedMovie.isWatched,
        posterPath: selectedMovie.posterPath,
        title: selectedMovie.title);
    try {
      await _myMoviesRepository.edit(movieUpdated);
      myMoviesList[index] = movieUpdated;
    } catch (e) {
      if (e.getResultCode() == 1555) {
        Get.defaultDialog(
            title: 'Ops...', content: Text('Filme já adicionada na lista'));
      }

      print(e);
    }
  }

  void loadData() async {
    moviesPopularList.assignAll(await _repository.getPopular());
  }

  @override
  void onInit() async {
    myMoviesList.assignAll(await _myMoviesRepository.getAll());
    super.onInit();
  }
}
