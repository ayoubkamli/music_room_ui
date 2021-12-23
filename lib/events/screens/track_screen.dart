import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/events/bloc/track_event/manage_track_event_cubit.dart';
import 'package:myapp/events/bloc/track_event/mange_track_event_state.dart';
import 'package:myapp/events/models/song_model.dart';
import 'package:myapp/events/networking/event_api.dart';
import 'package:myapp/events/repositories/event_repository.dart';

import 'package:myapp/events/screens/edit_event_screen.dart';
import 'package:myapp/events/widgets/future_image.dart';
import 'package:myapp/pages/tab_page.dart';
// import 'package:myapp/playlists/widgets/playlist_player_widget.dart';
import 'package:myapp/search/bloc/search_bloc.dart';
import 'package:myapp/search/screens/search_screen.dart';
import 'package:myapp/utils/is_current_user.dart';
import 'package:myapp/utils/is_subscribed.dart';
import 'package:myapp/widgets/playlist_player/notifier/play_button_notifier.dart';
import 'package:myapp/widgets/playlist_player/notifier/progress_notifier.dart';

import '../../main.dart';

const kUrl1 =
    'https://p.scdn.co/mp3-preview/a1514ea0f0c4f729a2ed238ac255f988af195569?cid=3a6f2fd862ef4b5e8e53c3d90edf526d';

class TrackEventView extends StatefulWidget {
  final AlbumData data;
  const TrackEventView({required this.data, Key? key}) : super(key: key);

  @override
  _TrackEventViewState createState() => _TrackEventViewState();
}

class _TrackEventViewState extends State<TrackEventView> {
  String message = 'Loading...';

  @override
  void initState() {
    super.initState();
    pageManager.removeSong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: getAppBar(),
      body: FutureBuilder<AlbumModel?>(
        future: EventRepository().getOneEvent(widget.data.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return getBody(snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'this event doesn\'t exist or deleted ',
                style: TextStyle(color: Colors.green),
              ),
            );
          }
          return waiting();
        },
      ),
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

  Widget getBody(AlbumModel data) {
    // var size = MediaQuery.of(context).size;

    print('this is the data ' + data.data.ownerId.toString());

    return BlocProvider(
      create: (context) => TrackEventCubit(),
      child: SingleChildScrollView(
        child: BlocConsumer<TrackEventCubit, TrackEventState>(
          listener: (context, state) {},
          builder: (context, state) {
            TrackEventCubit cubit = TrackEventCubit.get(context);

            cubit.eventId = data.data.id.toString();
            print('this is the cubit.event id ${cubit.eventId}');
            return Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: FutureBuilder<String>(
                        future: getImageUrl(data.data.image),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            // print(' snapshot.data! ' + snapshot.data!);
                            return Container(
                              width: 250,
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
                    // width: size.width - 80,
                    height: 110,
                    child: Column(
                      children: [
                        showEventInfo(data),
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
                // remoteUrl(),
                // ExampleApp(),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: List.generate(data.data.playlist.length, (index) {
                    return track(data.data.playlist[index], cubit.eventId,
                        data.data.ownerId, index);
                  }),
                )
              ],
            );
          },
        ),
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

  Widget showEventInfo(AlbumModel data) {
    return FutureBuilder<bool>(
        future: IsCurrentUser().isCurrent(data.data.ownerId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    label: Text(
                      'Start',
                      style: TextStyle(color: Colors.green),
                    ),
                    icon: Icon(
                      Icons.play_arrow,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      EventRepository().startEvent(data.data.id);
                    },
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
                  popUpMenu(data.data.id),
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
                  // subscrib(data),
                  FutureBuilder<String>(
                      future: IsSubscribed().isSubscribed(data),
                      builder: (constext, snapshoot) {
                        if (snapshoot.data == 'subscribed') {
                          return unsubscrib(data);
                        } else if (snapshoot.data == 'unsubscribed') {
                          return subscrib(data);
                        } else {
                          return Container();
                        }
                      })
                ],
              ),
              SizedBox(
                width: 10,
              ),
            ],
          );
        });
  }

  subscrib(AlbumModel data) {
    IsSubscribed().isSubscribed(data);
    return TextButton(
      onPressed: () {
        print('subscribe button pressed');
        EventRepository().subscribeEvent(data.data.id);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
      },
      child: Text('Subscribe'),
    );
  }

  unsubscrib(AlbumModel data) {
    return TextButton(
      onPressed: () {
        print('unsubscribe pressed');
        EventRepository().unsubscribeEvent(data.data.id);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
      },
      child: Text('Unsubscribe'),
    );
  }

  Widget popUpMenu(String eventId) {
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
                  builder: (context) => EditEventView(data: widget.data)),
            );
          }
          if (selectedValue == '2') {
            print('2');
            RemoveEvent().deleteEvent(eventId);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => TabView()));
          }
          if (selectedValue == '3') {
            print('3');

            showSearch(
                context: context,
                delegate: SearchScreen(
                  searchBloc: BlocProvider.of<SearchBloc>(context),
                  eventId: eventId,
                  type: 'trackEvent',
                ));
          }
          if (selectedValue == '4') {
            print('4');

            showSearch(
                context: context,
                delegate: SearchScreen(
                    searchBloc: BlocProvider.of<SearchBloc>(context),
                    eventId: eventId,
                    type: 'userEvent'));
          }
        },
        itemBuilder: (BuildContext ctx) => [
              PopupMenuItem(
                  child: Text('Edit event',
                      style: (TextStyle(color: Colors.white))),
                  value: '1'),
              PopupMenuItem(
                child: Text('Delete event',
                    style: (TextStyle(color: Colors.white))),
                value: '2',
              ),
              PopupMenuItem(
                child:
                    Text('add track', style: (TextStyle(color: Colors.white))),
                value: '3',
              ),
              PopupMenuItem(
                child:
                    Text('add user', style: (TextStyle(color: Colors.white))),
                value: '4',
              ),
            ]);
  }

  Widget remoteUrl() {
    // return PlayerWidget(url: kUrl1);
    return Container();
  }

  Widget track(PlaylistData data, String eventId, String ownerId, int index) {
    // EventModel songData = EventModel.fromJson(data);

    print('song data ------------------------ $data');
    print(data.previewUrl);
    print('this is the evnt is \\\\$eventId//');
    pageManager.addSong(data.previewUrl!, data.name!);
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
          FutureBuilder<bool>(
              future: IsCurrentUser().isCurrent(ownerId),
              builder: (context, snapshot) {
                print('-----> : |${snapshot.data}|');
                if (snapshot.hasData) {
                  if (snapshot.data == true) {
                    return removeTrack(eventId, data.trackId);
                  } else if (snapshot.data == false) {
                    return vote();
                  }
                }
                return SizedBox(
                  width: 10,
                );
              })
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

  removeTrack(eventId, trackId) {
    return BlocProvider(
        create: (context) => TrackEventCubit(),
        child: BlocConsumer<TrackEventCubit, TrackEventState>(
            listener: (context, state) {},
            builder: (context, state) {
              TrackEventCubit cubit = TrackEventCubit.get(context);

              return IconButton(
                  onPressed: () => cubit.remove(eventId, trackId),
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: Colors.white.withOpacity(0.5),
                  ));
            }));
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
            Text("Explore",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            Icon(Icons.list)
          ],
        ),
      ),
    );
  }
}

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
          // RepeatButton(),
          // PreviousSongButton(),
          PlayButton(),
          // NextSongButton(),
          // ShuffleButton(),
        ],
      ),
    );
  }
}

// class RepeatButton extends StatelessWidget {
//   const RepeatButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<RepeatState>(
//       valueListenable: pageManager.repeatButtonNotifier,
//       builder: (context, value, child) {
//         Icon icon;
//         switch (value) {
//           case RepeatState.off:
//             icon = Icon(Icons.repeat, color: Colors.grey);
//             break;
//           case RepeatState.repeatSong:
//             icon = Icon(Icons.repeat_one, color: Colors.green);
//             break;
//           case RepeatState.repeatPlaylist:
//             icon = Icon(Icons.repeat, color: Colors.green);
//             break;
//         }
//         return IconButton(
//           icon: icon,
//           color: Colors.green,
//           onPressed: pageManager.onRepeatButtonPressed,
//         );
//       },
//     );
//   }
// }

// class PreviousSongButton extends StatelessWidget {
//   const PreviousSongButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<bool>(
//       valueListenable: pageManager.isFirstSongNotifier,
//       builder: (_, isFirst, __) {
//         return IconButton(
//           icon: Icon(Icons.skip_previous, color: Colors.grey),
//           color: Colors.green,
//           onPressed: (isFirst) ? null : pageManager.onPreviousSongButtonPressed,
//         );
//       },
//     );
//   }
// }

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

// class NextSongButton extends StatelessWidget {
//   const NextSongButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<bool>(
//       valueListenable: pageManager.isLastSongNotifier,
//       builder: (_, isLast, __) {
//         return IconButton(
//           icon: Icon(Icons.skip_next, color: Colors.grey),
//           color: Colors.green,
//           onPressed: (isLast) ? null : pageManager.onNextSongButtonPressed,
//         );
//       },
//     );
//   }
// }

// class ShuffleButton extends StatelessWidget {
//   const ShuffleButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<bool>(
//       valueListenable: pageManager.isShuffleModeEnabledNotifier,
//       builder: (context, isEnabled, child) {
//         return IconButton(
//           icon: (isEnabled)
//               ? Icon(Icons.shuffle, color: Colors.green)
//               : Icon(Icons.shuffle, color: Colors.grey),
//           onPressed: pageManager.onShuffleButtonPressed,
//         );
//       },
//     );
//   }
// }
