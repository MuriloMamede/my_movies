import 'package:my_movies/app/global/constants.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseProvider {
  DataBaseProvider._();
  static final DataBaseProvider db = DataBaseProvider._();

  Database _database;
  //DatabaseFactory _databaseFactory;
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

      await database.execute("CREATE TABLE $USER_TABLE ("
          "$USER_ID INTEGER PRIMARY KEY AUTOINCREMENT,"
          "$USER_NAME TEXT,"
          "$USER_EMAIL INTEGER,"
          "$USER_BIRTHDATE INTEGER,"
          "$USER_PASSWORD TEXT"
          ")");
    });
  }
}
