import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies/app/data/model/movie_response_model.dart';
import 'package:my_movies/app/data/repository/myMovies_repository.dart';

import 'package:my_movies/app/global/constants.dart';

class MovieApiClient extends GetConnect {
  final String token = kApiKey;
  searchMovie(String query) async {
    var response = await get(kBaseUrl +
        "/search/movie?api_key=$token&language=pt-BR&query=$query&page=1&include_adult=false");

    if (response.hasError) {
      Get.defaultDialog(
          title: "Error Catch", content: Text("${response.statusText}"));
    }

    if (response.statusCode == 200) {
      final model = MovieResponseModel.fromMap(response.body);

      return model;
    } else {
      Get.defaultDialog(
          title: "Error", content: Text("${response.body['error']}"));
      return null;
    }
  }

  getRecommendedMovies(int idProfile) async {
    MyMoviesRepository _myMovies = MyMoviesRepository();
    String genresId = await _myMovies.getPreferredGenres(idProfile);

    var response = await get(kBaseUrl +
        "/discover/movie?api_key=$kApiKey&language=pt-BR&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=$genresId");

    if (response.hasError) {
      Get.defaultDialog(
          title: "Error Catch", content: Text("${response.statusText}"));
    }

    if (response.statusCode == 200) {
      final model = MovieResponseModel.fromMap(response.body);

      return model;
    } else {
      Get.defaultDialog(
          title: "Error", content: Text("${response.body['error']}"));
      return null;
    }
  }

  getPopular() async {
    var response = await get(
        kBaseUrl + "/movie/popular?page=1&api_key=$token&language=pt-BR");

    if (response.hasError) {
      Get.defaultDialog(
          title: "Error Catch", content: Text("${response.statusText}"));
    }

    if (response.statusCode == 200) {
      final model = MovieResponseModel.fromMap(response.body);

      return model;
    } else {
      Get.defaultDialog(
          title: "Error", content: Text("${response.body['error']}"));
      return null;
    }
  }
}
