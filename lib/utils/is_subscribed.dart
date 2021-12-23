import 'package:myapp/auth/models/user.dart';
import 'package:myapp/events/models/song_model.dart';
import 'package:myapp/profile/repository/profile_repository.dart';

class IsSubscribed {
  Future<UserData> getUserProfile() async {
    return await ProfileRepository().getUserProfile();
  }

  Future<String> isSubscribed(AlbumModel data) async {
    final user = await getUserProfile();
    print('this  iiss the id ' + user.data!.id!);

    bool isSub = data.data.subscribes!.contains(user.data!.id);
    print('this is isSub' + isSub.toString());
    if (isSub == true) {
      return 'subscribed';
    } else if (isSub == false) {
      return 'unsubscribed';
    }
    return 'false';
  }
}
