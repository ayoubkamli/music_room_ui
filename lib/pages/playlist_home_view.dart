import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/blocs/cubits/playlist_cubit.dart';
import 'package:myapp/models/playlist_model.dart';
import 'package:myapp/widgets/playlist_player.dart';
import 'package:myapp/blocs/states/playlist_state.dart';

class PlaylistHomeView extends StatefulWidget {
  const PlaylistHomeView({Key? key}) : super(key: key);

  @override
  _PlaylistHomeViewState createState() => _PlaylistHomeViewState();
}

class _PlaylistHomeViewState extends State<PlaylistHomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistCubit, PlaylistState>(
      builder: (context, state) {
        return Container(
          child: BlocBuilder<PlaylistCubit, PlaylistState>(
            builder: (context, state) {
              if (state is PlaylistLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PlaylistLoadedState) {
                final allPlaylist = state.props;
                return getBody(allPlaylist, 'Playlists', context);
              }
              if (state is PlaylistErrorState) {
                return Center(
                  child: Icon(
                    Icons.close,
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        );
      },
    );
  }
}

Widget getBody(List events, String exploreEvents, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Text(
          exploreEvents,
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
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
              final data = PlaylistModel.fromJson(events[0][index]);
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
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover),
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        data.name.toString(),
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
                            data.desc.toString(),
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

  PlaylistModel item = PlaylistModel.fromJson(data);

  print("item  $item");
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PlaylistPlayer(
        data: item,
      ),
    ),
  );
}
