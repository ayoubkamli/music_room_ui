import 'dart:convert';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:myapp/events/widgets/future_image.dart';
import 'package:myapp/pages/explore_view.dart';
import 'package:myapp/pages/tab_page.dart';
import 'package:myapp/playlists/manage_playlist_track/manage_playlist_track_cubit.dart';
import 'package:myapp/playlists/manage_playlist_track/manage_playlist_track_state.dart';
import 'package:myapp/playlists/repositories/playlist_repository.dart';
import 'package:myapp/playlists/screens/edit_palylist_view.dart';
import 'package:myapp/playlists/screens/p_model.dart';
import 'package:myapp/search/bloc/search_bloc.dart';
import 'package:myapp/search/screens/search_screen.dart';
import 'package:myapp/utils/is_current_user.dart';
import 'package:myapp/widgets/playlist_player/notifier/play_button_notifier.dart';
import 'package:myapp/widgets/playlist_player/notifier/progress_notifier.dart';
import 'package:myapp/widgets/playlist_player/notifier/repeat_button_notifier.dart';
import 'package:myapp/widgets/playlist_player/page_manager.dart';

class PlaylistTrackView extends StatefulWidget {
  final String playlistId;
  const PlaylistTrackView({Key? key, required this.playlistId})
      : super(key: key);

  @override
  State<PlaylistTrackView> createState() => _PlaylistTrackViewState();
}

// late final PageManager pageManager;

class _PlaylistTrackViewState extends State<PlaylistTrackView> {
  String message = 'Loading...';
  // Map<String, String> playlistSongs = {};

  // @override
  // void initState() {
  //   super.initState();
  //   pageManager = PageManager(playlistId: widget.playlistId);
  // }

  // @override
  // void dispose() {

  //   pageManager.dispose();

  //   super.dispose();
  // }

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

    return BlocProvider(
      create: (context) => PlaylistTrackCubit(),
      child: SingleChildScrollView(
        child: BlocConsumer<PlaylistTrackCubit, PlaylistTrackState>(
            listener: (context, state) {},
            builder: (context, state) {
              PlaylistTrackCubit cubit = PlaylistTrackCubit.get(context);

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
                  playerPlaylist(),
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

  Widget playerPlaylist() {
    return Column(
      children: [
        // CurrentSongTitle(),
        // Playlist(),
        // AddRemoveSongButtons(),
        AudioProgressBar(),
        AudioControlButtons(),
      ],
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

  Widget track(Tracks data, String eventId) {
    print('song data ------------------------ $data');
    print(data.previewUrl);

    pageManager.addSong(data.previewUrl);

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
          Expanded(
            child: TextButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => PlayerPlaylist()));
              },
              child: Text(
                data.name.toString(),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
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

// class CurrentSongTitle extends StatelessWidget {
//   const CurrentSongTitle({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<String>(
//       valueListenable: pageManager.currentSongTitleNotifier,
//       builder: (_, title, __) {
//         return Padding(
//           padding: const EdgeInsets.only(top: 8.0),
//           child: Text(title, style: TextStyle(fontSize: 40)),
//         );
//       },
//     );
//   }
// }

// class Playlist extends StatelessWidget {
//   const Playlist({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ValueListenableBuilder<List<String>>(
//         valueListenable: pageManager.playlistNotifier,
//         builder: (context, playlistTitles, _) {
//           return ListView.builder(
//             itemCount: playlistTitles.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text('${playlistTitles[index]}'),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class AddRemoveSongButtons extends StatelessWidget {
//   const AddRemoveSongButtons({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           FloatingActionButton(
//             onPressed: pageManager.addSong,
//             child: Icon(Icons.add),
//           ),
//           FloatingActionButton(
//             onPressed: pageManager.removeSong,
//             child: Icon(Icons.remove),
//           ),
//         ],
//       ),
//     );
//   }
// }

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          thumbColor: Colors.green,
          baseBarColor: Colors.grey,
          bufferedBarColor: Colors.green[200],
          progressBarColor: Colors.green,
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: pageManager.seek,
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RepeatButton(),
          PreviousSongButton(),
          PlayButton(),
          NextSongButton(),
          ShuffleButton(),
        ],
      ),
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RepeatState>(
      valueListenable: pageManager.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = Icon(Icons.repeat, color: Colors.grey);
            break;
          case RepeatState.repeatSong:
            icon = Icon(Icons.repeat_one, color: Colors.green);
            break;
          case RepeatState.repeatPlaylist:
            icon = Icon(Icons.repeat, color: Colors.green);
            break;
        }
        return IconButton(
          icon: icon,
          color: Colors.green,
          onPressed: pageManager.onRepeatButtonPressed,
        );
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: Icon(Icons.skip_previous, color: Colors.grey),
          color: Colors.green,
          onPressed: (isFirst) ? null : pageManager.onPreviousSongButtonPressed,
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: pageManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: Icon(Icons.play_arrow),
              color: Colors.green,
              iconSize: 32.0,
              onPressed: pageManager.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: Icon(Icons.pause),
              color: Colors.green,
              iconSize: 32.0,
              onPressed: pageManager.pause,
            );
        }
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: Icon(Icons.skip_next, color: Colors.grey),
          color: Colors.green,
          onPressed: (isLast) ? null : pageManager.onNextSongButtonPressed,
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? Icon(Icons.shuffle, color: Colors.green)
              : Icon(Icons.shuffle, color: Colors.grey),
          onPressed: pageManager.onShuffleButtonPressed,
        );
      },
    );
  }
}
