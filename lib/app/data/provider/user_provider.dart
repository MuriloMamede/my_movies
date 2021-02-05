import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:my_movies/app/data/model/profile_model.dart';
import 'package:my_movies/app/data/model/user_model.dart';
import 'package:my_movies/app/data/provider/dataBase_provider.dart';
import 'package:my_movies/app/global/constants.dart';

class UserApiClient {
  final databaseProvider = DataBaseProvider.db;

  Future<User> login(String email, String passwd) async {
    final db = await databaseProvider.database;
    User user;
    try {
      print(sha1.convert(utf8.encode(passwd)).toString());
      var result = await db.query(USER_TABLE,
          columns: [
            USER_EMAIL,
            USER_PASSWORD,
            USER_NAME,
            USER_BIRTHDATE,
            USER_ID
          ],
          where: '$USER_PASSWORD = ? and $USER_EMAIL = ?',
          whereArgs: [sha1.convert(utf8.encode(passwd)).toString(), email]);

      if (result.length > 0) {
        user = User.fromMap(result.first);
        return user;
      } else
        return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User> signUp(User user) async {
    final db = await databaseProvider.database;
    try {
      List<dynamic> result = await db.query(USER_TABLE,
          columns: [USER_EMAIL],
          where: '$USER_EMAIL = ?',
          whereArgs: [user.email]);
      if (result.length <= 0) {
        user.id = await db.insert(USER_TABLE, user.toMap());
        Profile profile = Profile(name: user.name, userId: user.id);
        profile.id = await db.insert(PROFILE_TABLE, profile.toMap());
        return user;
      } else
        return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
