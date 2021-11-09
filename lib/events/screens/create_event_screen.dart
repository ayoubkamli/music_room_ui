import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/events/bloc/all_event/event_cubit.dart';
import 'package:myapp/events/bloc/create_event/create_event_bloc.dart';
import 'package:myapp/events/bloc/create_event/create_event_event.dart';
import 'package:myapp/events/bloc/create_event/create_event_state.dart';
import 'package:myapp/widgets/multi_select_chip.dart';
import 'package:myapp/widgets/uplaod_photo.dart';
import 'package:myapp/events/repositories/event_repository.dart';
import 'package:myapp/formStatus/form_submission_status.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({Key? key}) : super(key: key);
  @override
  _CreateEventViewState createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  final _formKey = GlobalKey<FormState>();

  List<String> selectedPrefList = [];

  bool isSwitched = true;
  String visibilityText = 'Public Event';

  // int activeMenu1 = 0;
  // int activeMenu2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      appBar: getAppBar(),
      body: BlocProvider(
          create: (context) => CreateEventBloc(
              context.read<EventRepository>(), context.read<EventCubit>()),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(child: _createEventForm()),
            ],
          )),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Create Event",
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

  Widget _createEventForm() {
    return BlocListener<CreateEventBloc, CreateEventState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        } else if (formStatus is SubmissionSuccess) {
          _showSnackBar(context, 'Event Created with success');
          _formKey.currentState!.reset();
          print(
              'form status is submissionSuccess from create_event_view ${state.data}');
          setState(() {
            selectedPrefList = [];
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      UploadPhoto(title: 'upload photo', data: state.data!)));
        }
      },
      child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _nameField(),
                _descriptionField(),
                _switchButton(),
                _shipSelect(),
                _addEventButton(),
              ],
            ),
          )),
    );
  }

  Widget _nameField() {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide()),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            // icon: Icon(
            //   Icons.music_note,
            //   color: Colors.green,
            // ),
            labelText: 'Event name',
            labelStyle: TextStyle(color: Colors.green),
            hintText: 'Event name',
            // hintStyle: TextStyle(color: Colors.black),
          ),
          validator: (value) =>
              state.isEventNameValid ? null : 'Invalid event name',
          onChanged: (value) => context.read<CreateEventBloc>().add(
                CreateEventNameChanged(name: value),
              ),
        ),
      );
    });
  }

  Widget _descriptionField() {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide()),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              // icon: Icon(
              //   Icons.music_video,
              //   color: Colors.green,
              // ),
              labelText: 'Event Description',
              labelStyle: TextStyle(color: Colors.green),
              hintText: 'Description'),
          validator: (value) =>
              state.isEventDescriptionValid ? null : 'Invalid description',
          onChanged: (value) => context
              .read<CreateEventBloc>()
              .add(CreateEventDescriptionChanged(description: value)),
        ),
      );
    });
  }

  Widget _addEventButton() {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
        builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<CreateEventBloc>()
                          .add(CreateEventPrefChanged(prefs: selectedPrefList));
                      context
                          .read<CreateEventBloc>()
                          .add(CreateEventSubmitted());
                    }
                  },
                  child: Text('Create Event')),
            );
    });
  }

  Widget _shipSelect() {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                  child: Text(
                    'Add preferences',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => {
                    _showPrefDialog(),
                    context
                        .read<CreateEventBloc>()
                        .add(CreateEventPrefChanged(prefs: selectedPrefList))
                  },
                ),
                Text(selectedPrefList.join(" , ")),
              ],
            ),
          ),
        );
      },
    );
  }

  _showPrefDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Preferences'),
            content: MultiSelectChip(
              prefList,
              selectedPrefList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedPrefList = selectedList;
                });
              },
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Add'),
              ),
            ],
          );
        });
  }

  Widget _switchButton() {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(top: 10, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                visibilityText,
              ),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    if (isSwitched == true) {
                      visibilityText = 'Public Event ';
                      context
                          .read<CreateEventBloc>()
                          .add(CreateEventStatusChanged(status: 'public'));
                    } else {
                      visibilityText = 'Private Event';
                      context
                          .read<CreateEventBloc>()
                          .add(CreateEventStatusChanged(status: 'private'));
                    }
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    message = '';
  }
}
