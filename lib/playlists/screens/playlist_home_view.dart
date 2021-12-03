import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/playlists/all_playlist/all_playlist_cubit.dart';
import 'package:myapp/playlists/models/playlist_model.dart';
import 'package:myapp/playlists/screens/create_playlist_view.dart';
import 'package:myapp/playlists/widgets/get_event_track.dart';

class PlaylistHomeView extends StatefulWidget {
  const PlaylistHomeView({Key? key}) : super(key: key);

  @override
  _PlaylistHomeViewState createState() => _PlaylistHomeViewState();
}

class _PlaylistHomeViewState extends State<PlaylistHomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllPlaylistCubit, AllPlaylistState>(
      builder: (context, state) {
        return Container(
          child: BlocBuilder<AllPlaylistCubit, AllPlaylistState>(
            builder: (context, state) {
              if (state is AllPlaylistsLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AllPlaylistLoadedState) {
                final List<PlaylistData> allPlaylist = state.props;
                return getBody(allPlaylist, 'Playlists', context);
              }
              if (state is AllPlaylistErrorState) {
                return Center(
                  child: Icon(
                    Icons.close,
                  ),
                );
              } else {
                return Container(
                  child: (Text(
                    'data',
                    style: TextStyle(color: Colors.red),
                  )),
                );
              }
            },
          ),
        );
      },
    );
  }
}

Widget getBody(
    List<PlaylistData> playlists, String exploreEvents, BuildContext context) {
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
                  MaterialPageRoute(builder: (context) => CreateplaylistView()),
                );
              },
              style: ButtonStyle(
                //backgroundColor: MaterialStateProperty.all(Colors.green[400]),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color: Colors.green),
                )),
              ),
              child: Text(
                'Add playlist ',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.w400),
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
            children: List.generate(playlists.length, (index) {
              // final data = PlaylistData.fromJson(playlists);
              return Padding(
                padding: const EdgeInsets.only(right: 30),
                child: GestureDetector(
                  onTap: () {
                    print('-----');
                    print(playlists[index]);
                    print('-----');
                    getEventTracks(playlists[index], context);
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
                        playlists[index].name.toString(),
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
                            playlists[index].desc.toString(),
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
