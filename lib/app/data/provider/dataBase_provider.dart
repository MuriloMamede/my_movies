import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseProvider {
  DataBaseProvider._();
  static final DataBaseProvider db = DataBaseProvider._();

  static const String MYMOVIES_TABLE = 'myMovies';
  static const String MYMOVIES_ID = 'id';
  static const String MYMOVIES_TITLE = 'title';
  static const String MYMOVIES_POSTERPATH = 'posterPath';
  static const String MYMOVIES_ISWATCHED = 'isWatched';

  Database _database;
  deleteAll() async {
    final db = await database;
    db.rawDelete("DELETE from myMovies");
  }

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(join(dbPath, 'dados.db'), version: 1,
        onCreate: (Database database, int version) async {
      print("Creating table item");

      await database.execute("CREATE TABLE $MYMOVIES_TABLE ("
          "$MYMOVIES_ID INTEGER PRIMARY KEY,"
          "$MYMOVIES_TITLE TEXT,"
          "$MYMOVIES_ISWATCHED INTEGER,"
          "$MYMOVIES_POSTERPATH TEXT"
          ")");
    });
  }
}
