import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/pages/create_event_view.dart';
import 'package:myapp/pages/album_page.dart';
import 'package:myapp/models/song_model.dart';

import '../blocs/cubits/event_cubit.dart';
import '../models/event_model.dart';
import '../blocs/states/event_state.dart';

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

          /// floatingActionButton: FloatingActionButton.extended(
          ///   onPressed: () {
          ///     Navigator.push(
          ///       context,
          ///       MaterialPageRoute(builder: (context) => CreateEventView()),
          ///     );
          ///   },
          ///   label: const Text('ADD EVENT'),
          ///   icon: const Icon(Icons.add),
          ///   backgroundColor: Colors.green,
          /// ),
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
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateEventView()),
                  );
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                child: Text(
                  'ADD EVENT ',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
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
    );
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
