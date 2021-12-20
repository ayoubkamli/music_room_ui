import 'package:flutter/material.dart';
import 'package:myapp/auth/models/user.dart';
import 'package:myapp/events/screens/event_home_screen.dart';
import 'package:myapp/events/screens/my_events_screen.dart';
import 'package:myapp/pages/tab_page.dart';
import 'package:myapp/playlists/screens/playlist_home_view.dart';
import 'package:myapp/profile/repository/profile_repository.dart';
import 'package:myapp/profile/screen/profile.dart';
import 'package:myapp/widgets/playlist_player/page_manager.dart';

class ExploreView extends StatefulWidget {
  @override
  _ExploreViewState createState() => _ExploreViewState();
}

late final PageManager pageManager;
class _ExploreViewState extends State<ExploreView> {
  int activeTab = 0;

    @override
  void initState() {
    super.initState();
    pageManager = PageManager();
  }

  @override
  void dispose() {
    
    pageManager.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: getFooter(),
        body: getBody(context));
  }

  Widget explore() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EventHomeView(),
            SizedBox(
              height: 20,
            ),
            PlaylistHomeView(),
          ],
        ),
      ),
    );
  }

  Widget myEvents() {
    return SafeArea(child: MyEvents());
  }

  Widget getBody(BuildContext context) {
    return IndexedStack(
      index: activeTab,
      children: [
        explore(),
        TabView(),
        Center(
          child: Text(
            "Search",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FutureBuilder<UserData>(
          future: ProfileRepository().getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return EditProfileView(data: snapshot.data);
            }
            return CircularProgressIndicator();
          },
        ),
      ],
    );
  }

  Widget getFooter() {
    List items = [Icons.home, Icons.book, Icons.search, Icons.settings];
    return Container(
      height: 80,
      decoration: BoxDecoration(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return IconButton(
                icon: Icon(
                  items[index],
                  color: activeTab == index ? Colors.green : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    activeTab = index;
                  });
                });
          }),
        ),
      ),
    );
  }
}
