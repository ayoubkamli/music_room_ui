import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/events/events/event_event.dart';
import 'package:myapp/events/logic/event_bloc.dart';
import 'package:myapp/events/logic/event_cubit.dart';
import 'package:myapp/events/models/event_model.dart';
import 'package:myapp/events/logic/event_state.dart';
import 'package:myapp/events/widgets/future_image.dart';
import 'package:myapp/pages/explore_view.dart';

class AllEventsView extends StatefulWidget {
  const AllEventsView() : super();

  @override
  _AllEventsViewState createState() => _AllEventsViewState();
}

class _AllEventsViewState extends State<AllEventsView> {
  // int activeMenu1 = 0;
  /// int activeMenu2 = 0;
  /// int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: getAppBar('All events'),
      body: BlocBuilder<EventCubit, EventState>(builder: (context, state) {
        return Container(
          child: BlocBuilder<EventCubit, EventState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LoadedState) {
                final events = state.props;
                print('ok');
                return getBody(events, context);
              } else if (state is ErrorState) {
                print('${state.props}');
                return Center(
                  child: Icon(Icons.close),
                );
              } else {
                return Container(
                  child: Text(
                    'Somethins went error',
                    style: TextStyle(color: Colors.green),
                  ),
                );
              }
            },
          ),
        );
      }),
    );
  }

  PreferredSizeWidget getAppBar(String title) {
    return AppBar(
        automaticallyImplyLeading: true,
        title: Text('All Events'),
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            MaterialPageRoute(builder: (context) => ExploreView());
          },
        ));
  }

  Widget getBody(List events, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<EventCubit>(context).getAllEvents();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              children: List.generate(events[0].length, (index) {
                final data = EventModel.fromJson(events[0][index]);
                String url = data.imgUrl.toString();
                List<String>? s = url.split("/");
                String? imageUrl = "http://$ip/api/media/${s[s.length - 1]}";
                return Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: GestureDetector(
                    onTap: () {
                      // goToAlbum(events[0][index], context);
                    },
                    child: Column(
                      children: [
                        FutureBuilder<String>(
                          future: getImageUrl(imageUrl),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print(' snapshot.data! ' + snapshot.data!);
                              return Container(
                                // width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          snapshot.data!,
                                        ),
                                        fit: BoxFit.cover),
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                              );
                            }
                            return CircularProgressIndicator();
                          },
                        ),
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
                                          data.name,
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
                                        data.desc,
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
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ));
  }
}
