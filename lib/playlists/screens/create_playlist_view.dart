import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/constant/style.dart';
import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/playlists/blocs/create_playlist_State.dart';
import 'package:myapp/playlists/blocs/create_playlist_bloc.dart';
import 'package:myapp/playlists/blocs/playlist_cubit.dart';
import 'package:myapp/playlists/events/create_playlist_event.dart';
import 'package:myapp/playlists/repositories/playlist_repository.dart';
import 'package:myapp/widgets/multi_select_chip.dart';

class CreateplaylistView extends StatefulWidget {
  @override
  _CreateplaylistViewState createState() => _CreateplaylistViewState();
}

class _CreateplaylistViewState extends State<CreateplaylistView> {
  final _formKey = GlobalKey<FormState>();

  List<String> selectedPrefList = [];

  bool isSwitched = true;
  String visibilityText = 'Public Event';

  OutlineInputBorder textFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: BorderSide(color: const Color(0xff01d277)));

  // int activeMenu1 = 0;
  // int activeMenu2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: getAppBar(),
      body: BlocProvider(
          create: (context) => CreatePlaylistBloc(
              context.read<PlaylistRepository>(),
              context.read<PlaylistCubit>()),
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _createEventForm(),
              ],
            ),
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
    return BlocListener<CreatePlaylistBloc, CreatePlaylistState>(
      listener: (context, state) {
        final formStatus = state.playlistFormStatus;
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
      child: Container(
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
      ),
    );
  }

  Widget _nameField() {
    return BlocBuilder<CreatePlaylistBloc, CreatePlaylistState>(
        builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
            enabledBorder: outlineInputStyle,
            icon: Icon(
              Icons.music_note,
              color: Colors.white,
            ),
            hintText: 'Event name',
            hintStyle: TextStyle(color: Colors.white)),
        validator: (value) =>
            state.isPlaylistNameValid ? null : 'Invalid event name',
        onChanged: (value) => context.read<CreatePlaylistBloc>().add(
              CreatePlaylistNameChanged(name: value),
            ),
      );
    });
  }

  Widget _descriptionField() {
    return BlocBuilder<CreatePlaylistBloc, CreatePlaylistState>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: TextFormField(
          decoration: InputDecoration(
            enabledBorder: outlineInputStyle,
            icon: Icon(
              Icons.music_video,
              color: Colors.white,
            ),
            hintText: 'Description',
            hintStyle: TextStyle(color: Colors.white),
          ),
          validator: (value) =>
              state.isPlaylistDescriptionValid ? null : 'Invalid description',
          onChanged: (value) => context
              .read<CreatePlaylistBloc>()
              .add(CreatePlaylistDescriptionChanged(description: value)),
        ),
      );
    });
  }

  Widget _addEventButton() {
    return BlocBuilder<CreatePlaylistBloc, CreatePlaylistState>(
        builder: (context, state) {
      return state.playlistFormStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context
                      .read<CreatePlaylistBloc>()
                      .add(CreatePlaylistPrefChanged(prefs: selectedPrefList));
                  context
                      .read<CreatePlaylistBloc>()
                      .add(CreatePlaylistSubmitted());
                  //

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             UploadPhoto(title: 'upload photo')));
                  // //
                }
              },
              child: Text('Create Playlist'));
    });
  }

  Widget _shipSelect() {
    return BlocBuilder<CreatePlaylistBloc, CreatePlaylistState>(
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              TextButton(
                child: Text(
                  'Add preferences',
                  style: (TextStyle(color: Colors.white)),
                ),
                onPressed: () => {
                  _showPrefDialog(),
                  context
                      .read<CreatePlaylistBloc>()
                      .add(CreatePlaylistPrefChanged(prefs: selectedPrefList))
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
    return BlocBuilder<CreatePlaylistBloc, CreatePlaylistState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(top: 10, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                visibilityText,
                style: TextStyle(color: Colors.white),
              ),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    if (isSwitched == true) {
                      visibilityText = 'Public Event ';
                      context
                          .read<CreatePlaylistBloc>()
                          .add(CreatePlaylistStatusChanged(status: 'public'));
                    } else {
                      visibilityText = 'Private Event';
                      context
                          .read<CreatePlaylistBloc>()
                          .add(CreatePlaylistStatusChanged(status: 'private'));
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
