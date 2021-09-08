import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/widgets/event_player.dart';
import 'package:myapp/models/playlist_model.dart';
// import 'package:myapp/event/screens/music_details.dart';

const kUrl1 =
    'https://p.scdn.co/mp3-preview/a1514ea0f0c4f729a2ed238ac255f988af195569?cid=3a6f2fd862ef4b5e8e53c3d90edf526d';

class PlaylistPlayer extends StatefulWidget {
  final dynamic data;
  const PlaylistPlayer({required this.data, Key? key}) : super(key: key);

  @override
  _PlaylistPlayerState createState() => _PlaylistPlayerState();
}

class _PlaylistPlayerState extends State<PlaylistPlayer> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String? localFilePath;
  String? localAudioCacheURI;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: getAppBar(),
      body: getBody(widget.data),
    );
  }

  Widget getBody(dynamic data) {
    var size = MediaQuery.of(context).size;

    print('this is the data ' + data.toString());

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Container(
                  width: size.width - 60,
                  height: size.width - 60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(imageUrl), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(20)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.create_new_folder_outlined,
                        color: Colors.white,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Navigator.push(
                              // context,
                              // MaterialPageRoute(
                              // builder: (context) => ExampleApp()),
                              // );
                            },
                            child: Text(
                              data.name!,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 150,
                            child: Text(
                              data.desc!,
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
                      Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                    ],
                  ),
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
            children: List.generate(data.tracks!.length, (index) {
              return track(data.tracks![index]);
            }),
          )
        ],
      ),
    );
  }

  Widget remoteUrl() {
    return PlayerWidget(url: kUrl1);
  }

  Widget track(Tracks data) {
    // EventModel songData = EventModel.fromJson(data);

    print('song data ------------------------');
    print(data.previewUrl);
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => null,
            child: Text(
              data.name.toString(),
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
          ),
        ],
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
