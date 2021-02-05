import 'package:my_movies/app/data/provider/profile_provider.dart';

class ProfileRepository {
  final ProfileApiClient apiClient = ProfileApiClient();

  getUserProfiles(int id) {
    return apiClient.getUserProfiles(id);
  }

  getFirstUserProfile(int id) {
    return apiClient.getFirstUserProfile(id);
  }

  add(obj) {
    return apiClient.insertItem(obj);
  }
}
