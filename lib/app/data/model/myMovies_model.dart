/*
import 'package:my_movies/app/data/model/movie_model.dart';

class MyMoviesModel {
  MyMoviesModel(this.movie, this.id);

  final Movie movie;
  final int id;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_ITEM_NAME: nome,
      DatabaseProvider.COLUMN_ITEM_QTD: qtd,
      DatabaseProvider.COLUMN_ITEM_VALUE: value,
      DatabaseProvider.COLUMN_ITEM_ID: cod,
    };

    if (cod != null) {
      map[DatabaseProvider.COLUMN_ITEM_ID] = cod;
    }

    return map;
  }

  ItemModel.fromMap(Map<String, dynamic> map) {
    cod = map[DatabaseProvider.COLUMN_ITEM_ID];
    nome = map[DatabaseProvider.COLUMN_ITEM_NAME];
    qtd = map[DatabaseProvider.COLUMN_ITEM_QTD];
    value = map[DatabaseProvider.COLUMN_ITEM_VALUE];
  }
}*/
