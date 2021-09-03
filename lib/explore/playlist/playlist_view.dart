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
  // int activeMenu1 = 0;
  int activeMenu2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: getAppBar('Explore'),
        body: BlocBuilder<PlaylistCubit, PlaylistState>(
            builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedState) {
            final playlist = state.props;
            return getBody(playlist, 'Explore Events', context);
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            /// Navigator.push(
            ///   context,
            ///   MaterialPageRoute(builder: (context) => CreateEventView()),
            /// );
          },
          label: const Text('ADD PLAYLIST'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.green,
        ));
  }

  PreferredSizeWidget getAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
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
