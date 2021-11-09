import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/constant/constant.dart';
import 'package:myapp/events/bloc/all_event/event_cubit.dart';
import 'package:myapp/events/bloc/edit_event/edit_event_bloc.dart';
import 'package:myapp/events/bloc/edit_event/edit_event_event.dart';
import 'package:myapp/events/bloc/edit_event/edite_event_state.dart';

import 'package:myapp/events/repositories/event_repository.dart';
import 'package:myapp/events/screens/all_events_screen.dart';
import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/widgets/multi_select_chip.dart';

class EditEventView extends StatefulWidget {
  final dynamic data;
  EditEventView({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  _EditEventViewState createState() => _EditEventViewState();
}

class _EditEventViewState extends State<EditEventView> {
  final _formKey = GlobalKey<FormState>();

  List<String> selectedPrefList = [];

  bool isSwitched = true;
  String visibilityText = 'Public Event';

  @override
  Widget build(BuildContext context) {
    print(widget.data.sId.toString());

    return Scaffold(
      appBar: getAppBar(),
      body: BlocProvider(
          create: (context) => EditEventBloc(
              context.read<EventRepository>(), context.read<EventCubit>()),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(child: _editEventForm()),
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
            Text("Edit Event ${widget.data.name}",
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

  Widget _editEventForm() {
    return BlocListener<EditEventBloc, EditEventState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        } else if (formStatus is SubmissionSuccess) {
          _showSnackBar(context, 'Event edited with success');
          _formKey.currentState!.reset();
          print(
              'form status is submissionSuccess from create_event_view ${state.data}');
          setState(() {
            selectedPrefList = [];
          });
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) =>
          //               UploadPhoto(title: 'upload photo', data: state.data!)));

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AllEventsView()));
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
                _editEventButton(),
              ],
            ),
          )),
    );
  }

  Widget _nameField() {
    return BlocBuilder<EditEventBloc, EditEventState>(
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
          initialValue: widget.data.name,
          autofocus: true,
          validator: (value) =>
              state.isEventNameValid ? null : 'Invalid event name',
          onChanged: (value) => context.read<EditEventBloc>().add(
                EditEventNameChanged(name: value),
              ),
        ),
      );
    });
  }

  Widget _descriptionField() {
    return BlocBuilder<EditEventBloc, EditEventState>(
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
          // controller: TextEditingController()..text = widget.data.desc,
          initialValue: widget.data.desc,
          validator: (value) =>
              state.isEventDescriptionValid ? null : 'Invalid description',
          onChanged: (value) => context
              .read<EditEventBloc>()
              .add(EditEventDescriptionChanged(description: value)),
        ),
      );
    });
  }

  Widget _editEventButton() {
    return BlocBuilder<EditEventBloc, EditEventState>(
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
                          .read<EditEventBloc>()
                          .add(EditEventPrefChanged(prefs: selectedPrefList));
                      context
                          .read<EditEventBloc>()
                          .add(EditEventIdChanged(id: widget.data.sId));
                      context.read<EditEventBloc>().add(EditEventSubmitted());
                    }
                  },
                  child: Text('Edit Event')),
            );
    });
  }

  Widget _shipSelect() {
    setState(() {
      selectedPrefList = widget.data.musicPreference;
    });
    return BlocBuilder<EditEventBloc, EditEventState>(
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
                        .read<EditEventBloc>()
                        .add(EditEventPrefChanged(prefs: selectedPrefList))
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
    setState(() {
      if (widget.data.visibility == 'public') {
        isSwitched = true;
      } else {
        isSwitched = false;
      }
    });
    return BlocBuilder<EditEventBloc, EditEventState>(
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
                          .read<EditEventBloc>()
                          .add(EditEventStatusChanged(status: 'public'));
                    } else {
                      visibilityText = 'Private Event';
                      context
                          .read<EditEventBloc>()
                          .add(EditEventStatusChanged(status: 'private'));
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
