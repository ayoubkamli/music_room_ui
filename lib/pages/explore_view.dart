import 'package:flutter/material.dart';
import 'package:myapp/auth/models/user.dart';
import 'package:myapp/events/screens/event_home_screen.dart';
import 'package:myapp/events/screens/my_events_screen.dart';
import 'package:myapp/playlists/screens/playlist_home_view.dart';
import 'package:myapp/profile/repository/profile_repository.dart';
import 'package:myapp/profile/screen/profile.dart';

class ExploreView extends StatefulWidget {
  @override
  _ExploreViewState createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        // appBar: getAppBar('Explore'),
        bottomNavigationBar: getFooter(),
        body: getBody(context));
  }

  // PreferredSizeWidget getAppBar(String title) {
  //   return AppBar(
  //     backgroundColor: Colors.black,
  //     elevation: 0,
  //     title: Padding(
  //       padding: const EdgeInsets.only(left: 10, right: 10),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(title,
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.bold,
  //               )),
  //           Icon(Icons.list)
  //         ],
  //       ),
  //     ),
  //   );
  // }

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

        myEvents(),
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

        /// SearchTracksScreen(),
        /// Center(
        ///   child: TextButton(
        ///     onPressed: () {
        ///       context.read<SessionCubit>().signOut();
        ///     },
        ///     child: Text(
        ///       "Settings",
        ///       style: TextStyle(
        ///         fontSize: 20,
        ///         color: Colors.white,
        ///         fontWeight: FontWeight.bold,
        ///       ),
        ///     ),
        ///   ),
        /// )
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

/** return Scaffold(
      body: BlocBuilder<EventCubit, EventState>(builder: (context, state) {
        if (state is LoadingState) {
          print('Loading state was very fast');
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedState) {
          final events = state.props;
          print(events);
          print('this is evets from viewwwwwwwwwww ${state.events}');
          return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) => Card(
                    child: ListTile(
                      title: Text('${events[index][0]["name"]}'),
                    ),
                  ));
        } else if (state is ErrorState) {
          print('${state.props}');
          return Center(
              child: Icon(
            Icons.close,
          ));
        } else {
          return Container();
        }
      }),
    ); */
