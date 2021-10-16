import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/events/screens/all_events_view.dart';
import 'package:myapp/events/screens/album_page.dart';
import 'package:myapp/events/models/song_model.dart';
import 'package:myapp/events/screens/create_event_view.dart';

import '../logic/event_cubit.dart';
import '../models/event_model.dart';
import '../logic/event_state.dart';

class EventHomeScreen extends StatefulWidget {
  const EventHomeScreen({Key? key}) : super(key: key);

  @override
  _EventHomeScreenState createState() => _EventHomeScreenState();
}

class _EventHomeScreenState extends State<EventHomeScreen> {
  // int activeMenu1 = 0;
  int activeMenu2 = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        return Container(
          child: BlocBuilder<EventCubit, EventState>(builder: (context, state) {
            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedState) {
              final events = state.props;
              return getBody(events, 'Events', context);
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
        );
      },
    );
  }

  Widget getBody(List events, String exploreEvents, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                exploreEvents,
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.green,
                  ),
                  color: Colors.black,
                  onSelected: (selectedValue) {
                    print(selectedValue);
                    if (selectedValue == '1') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllEventsView()),
                      );
                    }
                    if (selectedValue == '2') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllEventsView()),
                      );
                    }
                    if (selectedValue == '3') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateEventView()),
                      );
                    }
                  },
                  itemBuilder: (BuildContext ctx) => [
                        PopupMenuItem(
                            child: Text('All Events',
                                style: (TextStyle(color: Colors.white))),
                            value: '1'),
                        PopupMenuItem(
                          child: Text('My Events',
                              style: (TextStyle(color: Colors.white))),
                          value: '2',
                        ),
                        PopupMenuItem(
                          child: Text('Create event',
                              style: (TextStyle(color: Colors.white))),
                          value: '3',
                        ),
                      ]),
            ],
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
                      print(events[0][index]);
                      print('-----');
                      goToAlbum(events[0][index], context);
                    },
                    child: Column(
                      children: [
                        image(data),
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
    );
  }

  Widget image(data) {
    if (data.imgUrl != null) {
      print(data.imgUrl);
      String url = data.imgUrl.toString();
      List<String>? s = url.split("/");
      String? imageUrl = "http://$ip/api/media/${s[s.length - 1]}";

      print(imageUrl);

      return Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(imageUrl), fit: BoxFit.cover),
            color: Colors.green,
            borderRadius: BorderRadius.circular(10)),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  Future<dynamic> goToAlbum(Map<String, dynamic> data, context) {
    print(data);
    print('++++++++++');

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
}
