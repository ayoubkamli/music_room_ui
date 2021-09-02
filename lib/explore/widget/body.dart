import 'package:flutter/material.dart';
import 'package:myapp/explore/screens/album_page.dart';
import 'package:myapp/explore/screens/song_model.dart';

import '../event/event_model.dart';

Widget getBody(List events, String exploreEvents, BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                exploreEvents,
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: List.generate(events[0].length, (index) {
                    final data = EventModel.fromJson(events[0][index]);
                    return Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: GestureDetector(
                        onTap: () {
                          print('-----');
                          print(events[0][index]["playlist"]);
                          print('-----');
                          goToAlbum(events[0][index], context);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(data.imgUrl),
                                      fit: BoxFit.cover),
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              data.name,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                width: 180,
                                child: Text(
                                  data.desc,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),
                                ))
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}

Future<dynamic> goToAlbum(Map<String, dynamic> data, context) {
  print(data);
  //SongModel item = SongModel.fromJson(data);
  AlbumModel item = AlbumModel.fromJson(data);
  print("item  $item");
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AlbumPage(
        data: item,
      ),
    ),
  );
}
