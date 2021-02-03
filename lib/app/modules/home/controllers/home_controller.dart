import 'package:get/get.dart';
import 'package:my_movies/app/data/model/movie_model.dart';

import 'package:my_movies/app/data/repository/movie_repository.dart';
import 'package:my_movies/app/data/repository/myMovies_repository.dart';

class HomeController extends GetxController {
  final MovieRepository _repository = MovieRepository();
  final MyMoviesRepository _myMoviesRepository = MyMoviesRepository();

  final moviesPopularList = <Movie>[].obs;
  var myMoviesList = <Movie>[].obs;

  void addtoMyList(int index) {
    myMoviesList.add(moviesPopularList[index]);
    _myMoviesRepository.add(moviesPopularList[index]);
  }

  void markAsWatched(index) {}

  void loadData() async {
    moviesPopularList.assignAll(await _repository.getPopular());
  }

  @override
  void onInit() async {
    myMoviesList.assignAll(await _myMoviesRepository.getAll());
    super.onInit();
  }
}
