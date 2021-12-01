import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/events/widgets/future_image.dart';
import 'package:myapp/playlists/all_playlist/all_playlist_cubit.dart';
import 'package:myapp/playlists/models/playlist_model.dart';

class AllPlaylistsView extends StatelessWidget {
  const AllPlaylistsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: blocLogic(),
    );
  }

  blocLogic() {
    return Container(
        padding: EdgeInsets.only(top: 20),
        child: BlocBuilder<AllPlaylistCubit, AllPlaylistState>(
            builder: (context, state) {
          if (state is AllPlaylistsLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AllPlaylistErrorState) {
            return Center(
              child: Text(
                'Somethins went wrong',
                style: TextStyle(color: Colors.green),
              ),
            );
          } else if (state is AllPlaylistLoadedState) {
            final List<PlaylistData> playlists = state.props;
            return allPlaylistBody(playlists, context);
          } else {
            return Center(
              child: Text(
                'Somethins went wrong',
                style: TextStyle(color: Colors.green),
              ),
            );
          }
        }));
  }

  allPlaylistBody(List<PlaylistData> playlists, BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<AllPlaylistCubit>(context).getAllPlaylist();
        },
        child: allPlaylist(playlists, context));
  }

  allPlaylist(List<PlaylistData> playlists, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Column(
          children: List.generate(playlists.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 30),
              child: GestureDetector(
                onTap: null,
                child: Column(
                  children: [
                    FutureBuilder<String>(
                        future: getImageUrl(playlists[index].image),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              height: 180,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(snapshot.data!),
                                    fit: BoxFit.cover),
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          }
                          return CircularProgressIndicator();
                        }),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: SizedBox(
                                    width: width - 135,
                                    child: Text(
                                      playlists[index].name!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: width - 135,
                                  child: Text(
                                    playlists[index].desc!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
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
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
