import 'package:my_movies/app/data/provider/myMovies_provider.dart';

class MyMoviesRepository {
  final MyMoviesApiClient apiClient = MyMoviesApiClient();

  getAll() {
    return apiClient.getItens();
  }

  getProfileMovies(idProfile) {
    return apiClient.getProfileMovies(idProfile);
  }

  delete(id) {
    return apiClient.deleteItem(id);
  }

  edit(obj) {
    return apiClient.updateItem(obj);
  }

  add(obj) {
    return apiClient.insertItem(obj);
  }

  getGenresId(idMovie) {
    return apiClient.getGenresId(idMovie);
  }

  getPreferedGenres(idProfile) {
    return apiClient.getPreferedGenres(idProfile);
  }
}
