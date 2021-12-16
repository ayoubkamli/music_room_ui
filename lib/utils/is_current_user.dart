import 'package:myapp/auth/models/user.dart';
import 'package:myapp/profile/repository/profile_repository.dart';

class IsCurrentUser {
  Future<UserData> getUserProfile() async {
    return await ProfileRepository().getUserProfile();
  }

  Future<bool> isCurrent(String id) async {
    print('|$id|');
    UserData user = await getUserProfile();
    if (user.data!.id == id) {
      return true;
    }
    return false;
  }
}
