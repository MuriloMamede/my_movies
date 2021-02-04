import 'package:my_movies/app/global/constants.dart';

class Profile {
  int id;
  String name;
  int userId;

  Profile({
    this.name,
    this.userId,
    this.id,
  });

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        name: json[PROFILE_NAME],
        userId: json[PROFILE_USER_ID],
        id: json[PROFILE_ID],
      );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      PROFILE_ID: this.id,
      PROFILE_USER_ID: this.userId,
      PROFILE_NAME: this.name,
    };

    if (id != null) {
      map[PROFILE_ID] = this.id;
    }

    return map;
  }
}
