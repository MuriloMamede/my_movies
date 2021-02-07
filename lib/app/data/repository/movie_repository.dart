import 'package:my_movies/app/data/model/movie_model.dart';
import 'package:my_movies/app/data/provider/movie_provider.dart';

import 'package:get/get.dart';

class MovieRepository {
  final MovieApiClient apiClient = Get.put(MovieApiClient());

  getPopular() async {
    List<Movie> list = <Movie>[];
    var response = await apiClient.getPopular();
    if (response != null) {
      response.movies.forEach((e) {
        list.add(e);
      });
    }

    return list;
  }

  searchMovie(String query) async {
    List<Movie> list = <Movie>[];
    var response = await apiClient.searchMovie(query);
    if (response != null) {
      response.movies.forEach((e) {
        list.add(e);
      });
    }

    return list;
  }

  getRecomendedMovies(idProfile) async {
    List<Movie> list = <Movie>[];
    var response = await apiClient.getRecomendedMovies(idProfile);
    if (response != null) {
      response.movies.forEach((e) {
        list.add(e);
      });
    }

    return list;
  }
}
