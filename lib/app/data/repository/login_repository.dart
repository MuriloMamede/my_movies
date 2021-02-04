import 'package:my_movies/app/data/model/user_model.dart';
import 'package:my_movies/app/data/provider/user_provider.dart';

class LoginRepository {
  final UserApiClient apiClient = UserApiClient();

  login(String email, String passwd) {
    return apiClient.login(email, passwd);
  }

  signUp(User user) {
    return apiClient.signUp(user);
  }
}
