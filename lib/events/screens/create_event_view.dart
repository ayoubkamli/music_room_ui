import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/events/blocs/create_event_bloc.dart';
import 'package:myapp/events/events/create_event_event.dart';
import 'package:myapp/events/repositories/create_event_state.dart';
import 'package:myapp/widgets/multi_select_chip.dart';
import 'package:myapp/widgets/uplaod_photo.dart';
import 'package:myapp/events/blocs/event_cubit.dart';
import 'package:myapp/events/repositories/event_repository.dart';
import 'package:myapp/formStatus/form_submission_status.dart';

class CreateEventView extends StatefulWidget {
  @override
  _CreateEventViewState createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  final _formKey = GlobalKey<FormState>();

  List<String> selectedPrefList = [];

  bool isSwitched = true;
  String visibilityText = 'Public Event';

  int activeMenu1 = 0;
  int activeMenu2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: BlocProvider(
          create: (context) => CreateEventBloc(
              context.read<EventRepository>(), context.read<EventCubit>()),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _createEventForm(),
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
            Text("Create Evet",
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
          setState(() {
            selectedPrefList = [];
          });
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
                _shipSelect(),
                _switchButton(),
                _addEventButton(),
              ],
            ),
          )),
    );
  }

  Widget _nameField() {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
        builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
            icon: Icon(Icons.music_note), hintText: 'Event name'),
        validator: (value) =>
            state.isEventNameValid ? null : 'Invalid event name',
        onChanged: (value) => context.read<CreateEventBloc>().add(
              CreateEventNameChanged(name: value),
            ),
      );
    });
  }

  Widget _descriptionField() {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
        builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
            icon: Icon(Icons.music_video), hintText: 'Description'),
        validator: (value) =>
            state.isEventDescriptionValid ? null : 'Invalid description',
        onChanged: (value) => context
            .read<CreateEventBloc>()
            .add(CreateEventDescriptionChanged(description: value)),
      );
    });
  }

  Widget _addEventButton() {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
        builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context
                      .read<CreateEventBloc>()
                      .add(CreateEventPrefChanged(prefs: selectedPrefList));
                  context.read<CreateEventBloc>().add(CreateEventSubmitted());
                  //

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UploadPhoto(title: 'upload photo')));
                  //
                }
              },
              child: Text('Create Event'));
    });
  }

  Widget _shipSelect() {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              TextButton(
                child: Text('Add preferences'),
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
