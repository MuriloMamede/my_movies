import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_movies/app/data/model/movie_model.dart';
import 'package:my_movies/app/data/model/profile_model.dart';

import 'package:my_movies/app/data/repository/movie_repository.dart';
import 'package:my_movies/app/data/repository/myMovies_repository.dart';
import 'package:my_movies/app/data/repository/profile_repository.dart';

class HomeController extends GetxController {
  final MovieRepository _repository = MovieRepository();
  final MyMoviesRepository _myMoviesRepository = MyMoviesRepository();
  final ProfileRepository _profileRepository = ProfileRepository();

  final TextEditingController nameProfileController = TextEditingController();
  final data = GetStorage();

  final moviesPopularList = <Movie>[].obs;
  var myMoviesList = <Movie>[].obs;
  var profilesList = <Profile>[].obs;
  int get userId => data.read("userId");
  int get profileId => data.read("profileId");

  void addtoMyList(int index) async {
    Movie selectedMovie = moviesPopularList[index];
    Movie movieUpdated = Movie(
        idTMDB: selectedMovie.id,
        isWatched: selectedMovie.isWatched,
        posterPath: selectedMovie.posterPath,
        idProfile: profileId,
        title: selectedMovie.title);
    try {
      Movie newMovie = await _myMoviesRepository.add(movieUpdated);
      if (newMovie == null) {
        Get.defaultDialog(
            title: 'Ops...', content: Text('Filme já adicionada na lista'));
      }
      myMoviesList.add(newMovie);
    } catch (e) {}
  }

  void selectPerfil(id) async {
    data.write("profileId", id);
    print(profileId);
    myMoviesList.assignAll(await _myMoviesRepository.getProfileMovies(id));
    Get.back();
  }

  void addProfile() async {
    Profile newProfile = await _profileRepository
        .add(Profile(name: nameProfileController.text, userId: userId));
    if (newProfile != null) {
      profilesList.add(newProfile);
      nameProfileController.clear();
      Get.back();
    } else {
      Get.back();
      Get.defaultDialog(
          title: 'Ops..',
          content: Text('Você só pode ter 4 perfis diferentes'));
    }
  }

  void markAsWatched(index) async {
    Movie selectedMovie = myMoviesList[index];
    Movie movieUpdated = Movie(
        idTMDB: selectedMovie.idTMDB,
        id: selectedMovie.id,
        isWatched: !selectedMovie.isWatched,
        posterPath: selectedMovie.posterPath,
        idProfile: profileId,
        title: selectedMovie.title);
    try {
      await _myMoviesRepository.edit(movieUpdated);
      myMoviesList[index] = movieUpdated;
    } catch (e) {
      if (e.getResultCode() == 1555) {
        Get.defaultDialog(
            title: 'Ops...', content: Text('Filme já adicionada na lista'));
      }
    }
  }

  void loadData() async {
    moviesPopularList.assignAll(await _repository.getPopular());
  }

  @override
  void onInit() async {
    print('id:' + profileId.toString());
    myMoviesList
        .assignAll(await _myMoviesRepository.getProfileMovies(profileId));
    profilesList.assignAll(await _profileRepository.getUserProfiles(userId));
    super.onInit();
  }
}
