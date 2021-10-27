import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      title: Text('Search track'),
      actions: [IconButton(onPressed: null, icon: Icon(Icons.search))],
    );
  }
}
