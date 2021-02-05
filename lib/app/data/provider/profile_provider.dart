import 'package:my_movies/app/data/model/profile_model.dart';

import 'package:my_movies/app/data/provider/dataBase_provider.dart';
import 'package:my_movies/app/global/constants.dart';

class ProfileApiClient {
  final databaseProvider = DataBaseProvider.db;
  Future<Profile> insertItem(Profile item) async {
    final db = await databaseProvider.database;
    var profiles = await db.query(PROFILE_TABLE,
        columns: [
          PROFILE_ID,
          PROFILE_NAME,
          PROFILE_USER_ID,
        ],
        where: '$PROFILE_USER_ID  = ?',
        whereArgs: [item.userId]);
    if (profiles.length < 4) {
      item.id = await db.insert(PROFILE_TABLE, item.toMap());
      return item;
    } else
      return null;
  }

  Future<List<Profile>> getUserProfiles(int id) async {
    final db = await databaseProvider.database;
    var profiles = await db.query(PROFILE_TABLE,
        columns: [
          PROFILE_ID,
          PROFILE_NAME,
          PROFILE_USER_ID,
        ],
        where: '$PROFILE_USER_ID  = ?',
        whereArgs: [id]);

    List<Profile> profileList = List<Profile>();

    profiles.forEach((currentItem) {
      Profile profile = Profile.fromMap(currentItem);

      profileList.add(profile);
    });

    return profileList;
  }

  Future<Profile> getFirstUserProfile(int id) async {
    final db = await databaseProvider.database;
    var profiles = await db.query(PROFILE_TABLE,
        columns: [
          PROFILE_ID,
          PROFILE_NAME,
          PROFILE_USER_ID,
        ],
        where: '$PROFILE_USER_ID  = ?',
        whereArgs: [id]);

    Profile profile = Profile.fromMap(profiles.first);

    return profile;
  }
}
