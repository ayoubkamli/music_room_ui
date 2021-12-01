import 'package:flutter/material.dart';
import 'package:myapp/events/screens/all_events_screen.dart';
import 'package:myapp/events/screens/my_events_screen.dart';
import 'package:myapp/playlists/screens/all_playlist_view.dart';
import 'package:myapp/playlists/screens/my_playlist_view.dart';

class TabView extends StatelessWidget {
  const TabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.green[800],
              indicatorColor: Colors.green,
              tabs: [
                Tab(
                  text: 'All Events',
                ),
                Tab(
                  text: 'My Events',
                ),
                Tab(
                  text: 'All Playlists',
                ),
                Tab(
                  text: 'My Playlists',
                ),
              ],
            ),
            title: Text(
              'Music Room',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: TabBarView(
            children: [
              AllEventsView(),
              MyEvents(),
              AllPlaylistsView(),
              MyPlaylistsView(),
            ],
          ),
        ));
  }
}
