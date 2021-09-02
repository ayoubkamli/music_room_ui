import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/explore/event/event_cubit.dart';
import 'package:myapp/explore/event/event_state.dart';
import 'package:myapp/explore/screens/explor.dart';

class EventView extends StatefulWidget {
  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.black,
            bottomNavigationBar: getFooter(),
            body: getBody());
      },
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: activeTab,
      children: [
        EventHomeScreen(),
        Center(
          child: Text(
            "Library",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Text(
            "Search",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Text(
            "Settings",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Widget getFooter() {
    List items = [Icons.home, Icons.book, Icons.search, Icons.settings];
    return Container(
      height: 80,
      decoration: BoxDecoration(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return IconButton(
                icon: Icon(
                  items[index],
                  color: activeTab == index ? Colors.green : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    activeTab = index;
                  });
                });
          }),
        ),
      ),
    );
  }
}

/** return Scaffold(
      body: BlocBuilder<EventCubit, EventState>(builder: (context, state) {
        if (state is LoadingState) {
          print('Loading state was very fast');
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedState) {
          final events = state.props;
          print(events);
          print('this is evets from viewwwwwwwwwww ${state.events}');
          return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) => Card(
                    child: ListTile(
                      title: Text('${events[index][0]["name"]}'),
                    ),
                  ));
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
    ); */
