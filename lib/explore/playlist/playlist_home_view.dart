import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/explore/playlist/playlist_cubit.dart';
import 'package:myapp/explore/playlist/playlist_state.dart';
import 'package:myapp/explore/widget/body.dart';

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
        return Scaffold(
          backgroundColor: Colors.black,
          body: BlocBuilder<PlaylistCubit, PlaylistState>(
            builder: (context, state) {
              if (state is PlaylistLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PlaylistLoadedState) {
                final allPlaylist = state.props;
                return getBody(allPlaylist, 'Explore Playlists', context);
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
