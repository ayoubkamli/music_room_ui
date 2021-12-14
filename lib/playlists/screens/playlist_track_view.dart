import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:myapp/events/widgets/future_image.dart';
import 'package:myapp/pages/tab_page.dart';
import 'package:myapp/playlists/manage_playlist_track/manage_playlist_track_cubit.dart';
import 'package:myapp/playlists/manage_playlist_track/manage_playlist_track_state.dart';
import 'package:myapp/playlists/repositories/playlist_repository.dart';
import 'package:myapp/playlists/screens/edit_palylist_view.dart';
import 'package:myapp/playlists/screens/p_model.dart';
import 'package:myapp/playlists/widgets/playlist_player_widget.dart';
import 'package:myapp/search/bloc/search_bloc.dart';
import 'package:myapp/search/screens/search_screen.dart';
import 'package:myapp/utils/is_current_user.dart';

const kUrl1 =
    'https://p.scdn.co/mp3-preview/a1514ea0f0c4f729a2ed238ac255f988af195569?cid=3a6f2fd862ef4b5e8e53c3d90edf526d';

class PlaylistTrackView extends StatefulWidget {
  final String playlistId;
  const PlaylistTrackView({Key? key, required this.playlistId})
      : super(key: key);

  @override
  State<PlaylistTrackView> createState() => _PlaylistTrackViewState();
}

class _PlaylistTrackViewState extends State<PlaylistTrackView> {
  String message = 'Loading...';
  // late PData playlistData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget waiting() {
    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        message = 'this event doesn\'t exist or deleted ';
      });
    });
    return Center(
      child: Text(
        message,
        style: TextStyle(color: Colors.green),
      ),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Playlist",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            // Icon(Icons.list)
          ],
        ),
      ),
    );
  }

  getBody() {
    print('get body was called');
    return FutureBuilder<Response?>(
      future: PlaylistRepository().getOnePlaylist(widget.playlistId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Pmodel playlist = Pmodel.fromJson(jsonDecode(snapshot.data!.body));
          print('${playlist.toJson()}');
          return dataBody(playlist);
          // return Container();
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'This playlist dosn\'t exist or deleleted',
              style: TextStyle(color: Colors.green),
            ),
          );
        }
        return waiting();
      },
    );
  }

  dataBody(Pmodel data) {
    var size = MediaQuery.of(context).size;
    // PData paylistData = PData.fromJson(data.data.toJson());

    return BlocProvider(
      create: (context) => PlaylistTrackCubit(),
      child: SingleChildScrollView(
        child: BlocConsumer<PlaylistTrackCubit, PlaylistTrackState>(
            listener: (context, state) {},
            builder: (context, state) {
              PlaylistTrackCubit cubit = PlaylistTrackCubit.get(context);

              // cubit.playlistId = data.id!;

              return Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: FutureBuilder<String?>(
                          future: getImageUrl(data.data.image),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print(' snapshot.data! ' + snapshot.data!);
                              return Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          snapshot.data!,
                                        ),
                                        fit: BoxFit.cover),
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                              );
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      width: size.width - 80,
                      height: 100,
                      child: Column(
                        children: [
                          showPlaylistInfo(data),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  remoteUrl(),
                  // ExampleApp(),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: List.generate(data.data.tracks.length, (index) {
                      print('hhhhhhhhhhhhhhhhhhh' +
                          data.data.tracks[index].toString());
                      return track(data.data.tracks[index], cubit.playlistId);
                    }),
                  )
                ],
              );
            }),
      ),
    );
  }

  Widget showPlaylistInfo(Pmodel data) {
    return FutureBuilder<bool>(
        future: IsCurrentUser().isCurrent(data.data.ownerId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.create_new_folder_outlined,
                    color: Colors.white,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        data.data.name,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 150,
                        child: Text(
                          data.data.desc,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  popUpMenu(data.data),
                ],
              );
            }
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    data.data.name,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 150,
                    child: Text(
                      data.data.desc,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
            ],
          );
        });
  }

  Widget popUpMenu(PData playlistData) {
    return PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.green,
        ),
        color: Colors.black,
        onSelected: (selectedValue) {
          print(selectedValue);
          if (selectedValue == '1') {
            print('1');

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditPlaylistView(data: playlistData)),
            );
          }
          if (selectedValue == '2') {
            print('2');
            PlaylistRepository()
                .deletePlaylist(PlaylistTrackCubit().playlistId);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => TabView()));
          }
          if (selectedValue == '3') {
            print('3');
            showSearch(
                context: context,
                delegate: SearchScreen(
                    searchBloc: BlocProvider.of<SearchBloc>(context),
                    eventId: playlistData.id,
                    type: 'trackPlaylist'));
          }
        },
        itemBuilder: (BuildContext ctx) => [
              PopupMenuItem(
                  child: Text('Edit playslit',
                      style: (TextStyle(color: Colors.white))),
                  value: '1'),
              PopupMenuItem(
                child: Text('Delete playlist',
                    style: (TextStyle(color: Colors.white))),
                value: '2',
              ),
              PopupMenuItem(
                child:
                    Text('add track', style: (TextStyle(color: Colors.white))),
                value: '3',
              ),
            ]);
  }

  Widget remoteUrl() {
    return PlayerWidget(url: kUrl1);
  }

  Widget track(Tracks data, String eventId) {
    print('song data ------------------------ $data');
    print(data.previewUrl);
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: () {},
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: data.popularity.toString(),
                    ),
                  ],
                ),
              )),
          TextButton(
            onPressed: () => null,
            child: Text(
              data.name.toString(),
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
          ),
          Column(
            children: [vote(), removeTrack(eventId, data.id)],
          )
        ],
      ),
    );
  }

  vote() {
    return TextButton(
        onPressed: null,
        child: Icon(Icons.arrow_upward_outlined,
            color: Colors.white.withOpacity(0.5)));
  }

  removeTrack(playlistId, trackId) {
    return BlocProvider(
        create: (context) => PlaylistTrackCubit(),
        child: BlocConsumer<PlaylistTrackCubit, PlaylistTrackState>(
            listener: (context, state) {},
            builder: (context, state) {
              PlaylistTrackCubit cubit = PlaylistTrackCubit.get(context);

              return IconButton(
                  onPressed: () =>
                      cubit.removePlaylistTrack(playlistId, trackId),
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: Colors.white.withOpacity(0.5),
                  ));
            }));
  }
}
