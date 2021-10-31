import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/search/bloc/search_bloc.dart';
import 'package:myapp/search/bloc/search_event.dart';
import 'package:myapp/search/bloc/search_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => showSearch(
                  context: context,
                  delegate: SearchTracksScreen(
                      searchBloc: BlocProvider.of<SearchBloc>(context))),
              icon: Icon(Icons.search))
        ],
      ),
    );
  }
}

class SearchTracksScreen extends SearchDelegate<List> {
  SearchBloc searchBloc;
  SearchTracksScreen({
    required this.searchBloc,
  });

  String? queryString;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, []);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    queryString = query;
    searchBloc.add(Search(query: query));
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        if (state is SearchUninitialized) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is SearchError) {
          return Center(child: Text('Faild to laod data'));
        }
        if (state is SearchLoaded) {
          // print('this is the searchLoaded from screen \n' +
          //     state.tracks.data.length.toString());
          if (state.tracks.data.isNotEmpty) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Column(
                  children: List.generate(state.tracks.data.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: GestureDetector(
                        onTap: () {
                          // print('-----');
                          // print(events[0][index]);
                          // print('-----');
                          // goToAlbum(events[0][index], context);
                        },
                        child: Column(
                          children: [
                            // print(' snapshot.data! ' + snapshot.data!);
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        state.tracks.data[index].images.first
                                            .url,
                                      ),
                                      fit: BoxFit.cover),
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              state.tracks.data[index].name,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                width: 180,
                                child: Text(
                                  state.tracks.data[index].artists.first.name,
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
            );
          }
          return (Center(
            child: Text('No result found'),
          ));
        }
        return Scaffold();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
