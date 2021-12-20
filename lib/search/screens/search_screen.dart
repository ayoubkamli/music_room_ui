import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/events/networking/event_api.dart';
import 'package:myapp/events/repositories/event_repository.dart';
import 'package:myapp/events/widgets/future_image.dart';
import 'package:myapp/playlists/repositories/playlist_repository.dart';
import 'package:myapp/search/bloc/search_bloc.dart';
import 'package:myapp/search/bloc/search_event.dart';
import 'package:myapp/search/bloc/search_state.dart';

/// class SearchScreen extends StatelessWidget {
///   const SearchScreen({
///     Key? key,
///   }) : super(key: key);

///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       appBar: AppBar(
///         actions: [
///           IconButton(
///               onPressed: () => showSearch(
///                   context: context,
///                   delegate: SearchTracksScreen(
///                       searchBloc: BlocProvider.of<SearchBloc>(context),
///                       eventId: )),
///               icon: Icon(Icons.search))
///         ],
///       ),
///     );
///   }
/// }

class SearchScreen extends SearchDelegate<List> {
  SearchBloc searchBloc;
  String eventId;
  String type;
  SearchScreen({
    required this.eventId,
    required this.searchBloc,
    required this.type,
  });

  String? queryString;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, []);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    queryString = query;
    // if query
    if (type == 'trackEvent' || type == 'trackPlaylist') {
      searchBloc.add(SearchTrack(query: query));
    }
    if (type == 'userEvent' || type == 'userPlaylist') {
      searchBloc.add(SearchUser(query: query));
    }

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        if (state is SearchUninitialized) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is SearchError) {
          return Center(child: Text('Faild to laod data'));
        }
        if (state is SearchTrackLoaded) {
          // print('this is the searchLoaded from screen \n' +
          //     state.tracks.data.length.toString());
          if (state.tracks.data.isNotEmpty) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: List.generate(state.tracks.data.length, (index) {
                    print('${state.tracks.data[index].trakId} \n');
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(right: 30),
                      child: GestureDetector(
                        onTap: () {
                          /// print('-----');
                          /// print('${state.tracks.data[index].trakId}');
                          /// print('-----');
                          String trackId = state.tracks.data[index].trakId;
                          print('this is the event id ${eventId.toString()}');
                          print('this is the track id ${trackId.toString()}');
                          print('this is hte type $type');
                          if (type == 'trackEvent') {
                            addTrackEvent(trackId, eventId);
                          }
                          if (type == 'trackPlaylist') {
                            addTrackPlaylist(trackId, eventId);
                          }
                          if (type == 'userEvent') {
                            print('addUserToEvent(eventId, userId);');
                          }

                          // eventTracks(events[0][index], context);
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // print(' snapshot.data! ' + snapshot.data!);
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            state.tracks.data[index].images
                                                .first.url,
                                          ),
                                          fit: BoxFit.cover),
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                ),

                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          150,
                                      child: Text(
                                        state.tracks.data[index].name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          150,
                                      child: Text(
                                        state.tracks.data[index].artists.first
                                            .name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),

                                Icon(Icons.more_vert)
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          }
          return (Center(
            child: Text('No result found'),
          ));
        }
        if (state is SearchUserLoaded) {
          print('this is the searchLoaded from screen \n' +
              state.users.length.toString());
          if (state.users.isNotEmpty) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: List.generate(state.users.length, (index) {
                    print('${state.users[index]} \n');
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(right: 30),
                      child: GestureDetector(
                        onTap: () {
                          /// print('-----');
                          /// print('${state.tracks.data[index].trakId}');
                          /// print('-----');
                          String userId = state.users[index].id.toString();
                          print('this is the event id ${eventId.toString()}');
                          print('user id $userId');
                          if (type == 'userPlaylist') {
                            addUserPlaylist(userId, eventId);
                          }
                          if (type == 'userEvent') {
                            addUser(userId, eventId);
                          }

                          // eventTracks(events[0][index], context);
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // print(' snapshot.data! ' + snapshot.data!);
                                SizedBox(
                                  width: 5,
                                ),
                                FutureBuilder<String>(
                                    future:
                                        getImageUrl(state.users[index].picture),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    snapshot.data.toString(),
                                                  ),
                                                  fit: BoxFit.cover),
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        );
                                      } else {
                                        return Container(
                                          width: 40,
                                          height: 40,
                                          // child: Image.asset(
                                          //     'assets/images/user_placeholder.png'),
                                          decoration: BoxDecoration(
                                              // image: DecorationImage(
                                              //   image:
                                              //   fit: BoxFit.cover),

                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        );
                                      }
                                    }),

                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          150,
                                      child: Text(
                                        state.users[index].username.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: MediaQuery.of(context).size.width -
                                    //       150,
                                    //   child: Text(
                                    //     state.tracks.data[index].artists.first
                                    //         .name,
                                    //     overflow: TextOverflow.ellipsis,
                                    //     maxLines: 1,
                                    //     textAlign: TextAlign.start,
                                    //     style: TextStyle(
                                    //         fontSize: 12,
                                    //         color: Colors.grey,
                                    //         fontWeight: FontWeight.w600),
                                    //   ),
                                    // ),
                                  ],
                                ),

                                Icon(Icons.more_vert)
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          }

          return (Center(
            child: Text('No result found'),
          ));
        }
        return Scaffold();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  addTrackEvent(String trackId, String eventId) {
    print('add event $eventId to track $trackId');
    AddTrackToEvent().addTrackToEvent(eventId, trackId);
  }

  addTrackPlaylist(String trackId, String playlistId) {
    print('add track $trackId to playlist $eventId');
    PlaylistRepository().addTrackPlaylist(playlistId, trackId);
  }

  addUser(String userId, String eventID) {
    print('userId ----> $userId \n eventId -------> $eventId');
    EventRepository().subscribeEvent(eventId);
  }

  addUserPlaylist(String userId, String eventID) {
    print('userId ----> $userId \n eventId -------> $eventId');
    PlaylistRepository().addUserPlaylist(eventId, userId);
  }
}
