import 'package:get/get.dart';
import 'package:my_movies/app/data/model/movie_model.dart';

import 'package:my_movies/app/data/repository/movie_repository.dart';

class HomeController extends GetxController {
  final MovieRepository repository = MovieRepository();

  final moviesPopularList = <Movie>[].obs;
  var myMoviesList = <Movie>[].obs;

  @override
  void onInit() {
    //loadData();

    super.onInit();
  }

  void addtoMyList(index) {}
  void markAsWatched(index) {}
  void loadData() async {
    moviesPopularList.assignAll(await repository.getPopular());

    print('loadData');
  }
}
