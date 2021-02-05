import 'package:my_movies/app/data/model/movie_model.dart';
import 'package:my_movies/app/data/provider/dataBase_provider.dart';
import 'package:my_movies/app/global/constants.dart';

class MyMoviesApiClient {
  final databaseProvider = DataBaseProvider.db;

  Future<List<Movie>> getItens() async {
    final db = await databaseProvider.database;
    var itens = await db.query(MYMOVIES_TABLE, columns: [
      MYMOVIES_TITLE,
      MYMOVIES_POSTERPATH,
      MYMOVIES_ISWATCHED,
      MYMOVIES_ID,
      MYMOVIES_ID_PROFILE,
      MYMOVIES_ID_TMDB,
    ]);

    List<Movie> itemList = List<Movie>();

    itens.forEach((currentItem) {
      Movie item = Movie.fromDBMap(currentItem);

      itemList.add(item);
    });

    return itemList;
  }

  Future<List<Movie>> getProfileMovies(int idProfile) async {
    final db = await databaseProvider.database;
    var itens = await db.query(MYMOVIES_TABLE,
        columns: [
          MYMOVIES_TITLE,
          MYMOVIES_POSTERPATH,
          MYMOVIES_ISWATCHED,
          MYMOVIES_ID,
          MYMOVIES_ID_PROFILE,
          MYMOVIES_ID_TMDB,
        ],
        where: '$MYMOVIES_ID_PROFILE = ?',
        whereArgs: [idProfile]);

    List<Movie> itemList = List<Movie>();

    itens.forEach((currentItem) {
      Movie item = Movie.fromDBMap(currentItem);

      itemList.add(item);
    });

    return itemList;
  }

  Future<Movie> insertItem(Movie item) async {
    final db = await databaseProvider.database;
    bool hasMovie = false;
    List<Movie> itemList = List<Movie>();
    itemList = await getProfileMovies(item.idProfile);
    itemList.forEach((element) {
      if (element.idTMDB == item.idTMDB) hasMovie = true;
    });
    if (!hasMovie) {
      item.id = await db.insert(MYMOVIES_TABLE, item.toMap());
      print(item);
      return item;
    }
    return null;
  }

  Future<int> deleteItem(int id) async {
    final db = await databaseProvider.database;

    return await db.delete(
      MYMOVIES_TABLE,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateItem(Movie item) async {
    final db = await databaseProvider.database;

    return await db.update(
      MYMOVIES_TABLE,
      item.toMap(),
      where: "id = ?",
      whereArgs: [item.id],
    );
  }
}
