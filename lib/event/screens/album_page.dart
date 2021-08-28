import 'package:flutter/material.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/event/screens/song_model.dart';

class AlbumPage extends StatefulWidget {
  final AlbumModel data;
  const AlbumPage({required this.data, Key? key}) : super(key: key);

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: getAppBar(),
      body: getBody(widget.data),
    );
  }

  Widget getBody(AlbumModel data) {
    var size = MediaQuery.of(context).size;

    print('this is the data ' + data.toString());

    // SongModel s = SongModel.fromJson(data);
    // print('ssssssssssssssssss--------->>>> ${s}');

    // final newData = data.toString();
    // final data2 = jsonDecode(newData);

    // final s = songModelFromJson(data2);

    /// EventModel songData = EventModel.fromJson(data);
    /// String s = songData.toString() + ' ----- test';
    // print('s is s --------' + s);

    /// EventModel songData = EventModel.fromJson(data);

    /// String newData = songData.name.toString();
    /*   print(
        'songData.images.toString() +++++++++++++++++++++++++ ${songData.toString()}'); */
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
                            onPressed: () {},
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
          Column(
            children: List.generate(data.playlist!.length, (index) {
              return track(data.playlist![index]);
            }),
          )
        ],
      ),
    );
  }

  Widget track(Playlist data) {
    // EventModel songData = EventModel.fromJson(data);

    /// print('song data ------------------------');
    /// print(songData.toJson());
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
                      text: data.vote.toString(),
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
          vote(),
        ],
      ),
    );
  }

  vote() {
    return TextButton(
        onPressed: null,
        child: Icon(Icons.thumb_up_outlined,
            color: Colors.white.withOpacity(0.5)));
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

  // Future<dynamic> goToAlbum(dynamic data) {
  //   return Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => AlbumPage(
  //               data: data,
  //             )),
  //   );
  // }
}
