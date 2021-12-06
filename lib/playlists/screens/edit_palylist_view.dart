import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/events/widgets/future_image.dart';
import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/playlists/bloc/edit_playlist.dart/edit_playlist_event.dart';
import 'package:myapp/playlists/bloc/edit_playlist.dart/edit_playlist_bloc.dart';
import 'package:myapp/playlists/bloc/edit_playlist.dart/edit_playlist_state.dart';
import 'package:myapp/playlists/repositories/playlist_repository.dart';
import 'package:myapp/playlists/screens/p_model.dart';
import 'package:myapp/widgets/multi_select_chip.dart';
import 'package:myapp/widgets/uplaod_profile_photo.dart';

class EditPlaylistView extends StatefulWidget {
  final PData data;
  const EditPlaylistView({Key? key, required this.data}) : super(key: key);

  @override
  _EditPlaylistViewState createState() => _EditPlaylistViewState();
}

class _EditPlaylistViewState extends State<EditPlaylistView> {
  final _formKey = GlobalKey<FormState>();

  List<String> selectedPrefList = [];

  late bool isSwitched;

  String visibilityText = 'Public Paylist';

  @override
  void initState() {
    super.initState();
    setState(() {
      print(widget.data.visibility);
      if (widget.data.visibility == 'public') {
        isSwitched = true;
      } else {
        isSwitched = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: BlocProvider(
        create: (context) => EditPlaylistBloc(
          context.read<PlaylistRepository>(),
          // context.read<MyPlaylistCubit>()
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: _editPaylistForm(),
            ),
          ],
        ),
      ),
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
            Text("Edit Event ",
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

  _editPaylistForm() {
    return BlocListener<EditPlaylistBloc, EditPlaylistState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, 'Something went wrong');
        } else if (formStatus is SubmissionSuccess) {
          _showSnackBar(context, 'Playlist Created with success');
          _formKey.currentState!.reset();
          setState(() {
            selectedPrefList = [];
          });
        }
      },
      child: form(),
    );
  }

  form() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _playlistPicture(),
            _editImageButton(),
            _nameField(),
            _descriptionField(),
            _switchButton(),
            _shipSelect(),
            _editEventButton(),
          ],
        ),
      ),
    );
  }

  Widget _playlistPicture() {
    return FutureBuilder<Response?>(
        future: PlaylistRepository().getOnePlaylist(widget.data.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Pmodel data =
                Pmodel.fromJson(jsonDecode(snapshot.data!.body.toString()));
            return FutureBuilder<String>(
                future: getImageUrl(data.data.image),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(snapshot.data!),
                              fit: BoxFit.cover),
                          color: Colors.green),
                    );
                  }
                  return CircularProgressIndicator();
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _editImageButton() {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UploadProfilePhoto(
                        title: 'upload photo',
                        apiUrl: '$playlistUrl',
                        id: widget.data.id,
                      )));
        },
        child: Text('edit image'));
  }

  Widget _nameField() {
    return FutureBuilder<Response?>(
        future: PlaylistRepository().getOnePlaylist(widget.data.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Pmodel playlistData =
                Pmodel.fromJson(jsonDecode(snapshot.data!.body));
            return BlocBuilder<EditPlaylistBloc, EditPlaylistState>(
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
                    labelText: 'Playlist name',
                    labelStyle: TextStyle(color: Colors.green),
                    hintText: 'Playlist name',
                    // hintStyle: TextStyle(color: Colors.black),
                  ),
                  initialValue: playlistData.data.name,
                  autofocus: true,
                  // validator: (value) =>
                  //     state.isNameValide ? null : 'Invalid event name',
                  onChanged: (value) => context
                      .read<EditPlaylistBloc>()
                      .add(EditPlaylistNameChanged(name: value)),
                ),
              );
            });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _descriptionField() {
    return FutureBuilder<Response?>(
        future: PlaylistRepository().getOnePlaylist(widget.data.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Pmodel playlistData =
                Pmodel.fromJson(jsonDecode(snapshot.data!.body));
            return BlocBuilder<EditPlaylistBloc, EditPlaylistState>(
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
                      labelText: 'Playlist Description',
                      labelStyle: TextStyle(color: Colors.green),
                      hintText: 'Description'),
                  // controller: TextEditingController()..text = widget.data.desc,
                  initialValue: playlistData.data.desc,
                  // validator: (value) =>
                  //     state.isDescriptionValid ? null : 'Invalid description',
                  onChanged: (value) => context
                      .read<EditPlaylistBloc>()
                      .add(EditPlaylistDescriptionChanged(description: value)),
                ),
              );
            });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _switchButton() {
    // setState(() {
    //   if (widget.data.visibility == 'public') {
    //     isSwitched = true;
    //   } else {
    //     isSwitched = false;
    //   }
    // });
    return FutureBuilder<Response?>(
        future: PlaylistRepository().getOnePlaylist(widget.data.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocBuilder<EditPlaylistBloc, EditPlaylistState>(
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
                              context.read<EditPlaylistBloc>().add(
                                  EditPlaylistStatusChanged(
                                      visiblity: 'public'));
                            } else {
                              visibilityText = 'Private Event';
                              context.read<EditPlaylistBloc>().add(
                                  EditPlaylistStatusChanged(
                                      visiblity: 'private'));
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
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _shipSelect() {
    setState(() {
      selectedPrefList = widget.data.musicPreference;
    });
    return FutureBuilder<Response?>(
        future: PlaylistRepository().getOnePlaylist(widget.data.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocBuilder<EditPlaylistBloc, EditPlaylistState>(
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                            context.read<EditPlaylistBloc>().add(
                                EditPlaylistPrefChanged(
                                    prefs: selectedPrefList))
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
          return Center(
            child: CircularProgressIndicator(),
          );
        });
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

  Widget _editEventButton() {
    return BlocBuilder<EditPlaylistBloc, EditPlaylistState>(
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
                      context.read<EditPlaylistBloc>().add(
                          EditPlaylistPrefChanged(prefs: selectedPrefList));
                      context
                          .read<EditPlaylistBloc>()
                          .add(EditPlaylistIdChanged(id: widget.data.id));
                      context
                          .read<EditPlaylistBloc>()
                          .add(EditPlaylistSubmitted());
                    }
                  },
                  child: Text('Save Changes')),
            );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    message = '';
  }
}
