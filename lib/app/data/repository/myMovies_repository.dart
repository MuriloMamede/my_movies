import 'package:my_movies/app/data/provider/myMovies_provider.dart';

class MyMoviesRepository {
  final MyMoviesProvider apiClient = MyMoviesProvider();

  getAll() {
    return apiClient.getItens();
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
}