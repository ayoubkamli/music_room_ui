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
          if (state.tracks.isEmpty) {
            return (Center(
              child: Text('No Result'),
            ));
          }
          return (Center(
            child: Text(state.tracks.toString()),
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
