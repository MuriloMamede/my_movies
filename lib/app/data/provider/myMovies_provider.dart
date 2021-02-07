import 'dart:collection';

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
          MYMOVIES_GENRES_ID,
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

  Future<String> getGenresId(int idMovie) async {
    final db = await databaseProvider.database;
    var itens = await db.query(MYMOVIES_TABLE,
        columns: [
          MYMOVIES_GENRES_ID,
        ],
        where: '$MYMOVIES_ID = ?',
        whereArgs: [idMovie]);

    String genresId = '';
    genresId += itens.first[MYMOVIES_GENRES_ID];

    return genresId;
  }

  Future<String> getPreferredGenres(int idProfile) async {
    //pega todos os filmes que o perfil adicionou na lista
    List<Movie> movies = await getProfileMovies(idProfile);
    String genresId = '';

    //para cada filme na lista pega os id dos generos e adiciona em uma só string
    for (var i = 0; i < movies.length; i++) {
      if (i == movies.length - 1) {
        genresId += await getGenresId(movies[i].id);
      } else
        genresId += await getGenresId(movies[i].id) + ',';
    }

    Map<String, int> occurrences = {};

    var idList =
        genresId.split(","); //transforma a string de ids em uma lista de ids

/* 
  Trasnformar lista de String em um map, once a chave
  é o id do genero e o valor a quantidade de vezes
  que o genero aparece na lista
 */
    idList.forEach((element) {
      int count = 0;
      if (occurrences.containsKey(element)) {
        count = occurrences[element] + 1;
      } else
        count = 1;
      occurrences[element] = count;
    });

    //cria um novo map ordenado pelo valor armazenado em cada chave
    var sortedKeys = occurrences.keys.toList(growable: false)
      ..sort((k1, k2) => occurrences[k2].compareTo(occurrences[k1]));
    LinkedHashMap idSorted = new LinkedHashMap.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => occurrences[k]);
    int count = 0;
    genresId = '';

    //pega as 3 primeiras chaves do map ordenado e adiciona a string de ids
    idSorted.forEach((key, value) {
      //testar se idSorted tem só uma posicao
      if (idSorted.length == 1) {
        genresId += key;
        count++;
      } else {
        if (count < 3) {
          if (count == 2) {
            genresId += key;
            count++;
          } else {
            genresId += key + ",";
            count++;
          }
        }
      }
    });
    return genresId;
  }

  Future<Movie> insertItem(Movie item) async {
    final db = await databaseProvider.database;

    try {
      await db.insert(MYMOVIES_TABLE, item.toMap());
      return item;
    } catch (e) {
      return null;
    }
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
