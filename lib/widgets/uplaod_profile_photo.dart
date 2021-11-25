import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/auth/models/user.dart';
import 'package:myapp/events/bloc/all_event/event_cubit.dart';
import 'package:myapp/events/models/song_model.dart';
import 'package:myapp/events/repositories/event_repository.dart';
import 'package:myapp/events/screens/edit_event_screen.dart';
import 'package:myapp/profile/repository/profile_repository.dart';
import 'package:myapp/profile/screen/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime_type/mime_type.dart';

class UploadProfilePhoto extends StatefulWidget {
  final String title;
  // final UploadPhotoModel data;
  final String apiUrl;
  final String id;

  const UploadProfilePhoto(
      {Key? key, required this.title, required this.apiUrl, required this.id})
      : super(key: key);

  @override
  _UploadProfilePhotoState createState() => _UploadProfilePhotoState();
}

class _UploadProfilePhotoState extends State<UploadProfilePhoto> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  XFile? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<StreamedResponse> uploadImage(filepath, url) async {
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('Token');
    String bearerToken = 'Bearer $token';
    // UploadPhotoModel data = widget.data;

    /********** */
    // print('this is the owner id' + data.data!.ownerId.toString());

    /********** */
    print('url  : filepath--> $filepath \n $url');
    // print("type " + mimeType!);
    List? mimeType = mime(filepath)!.split("/");

    // print("mimeType " + mimeType!);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', filepath,
        contentType: new MediaType(mimeType[0], mimeType[1])));

    request.headers.addAll({
      'Authorization': '$bearerToken',
    });

    var res = await request.send();
    http.Response.fromStream(res).then((response) {
      print('response.body from upload_photo' + response.body[0]);
    });
    return res;
  }

  Future<void> retriveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      print('Retrieve error ' + response.exception!.code);
    }
  }

  Widget _previewImage() {
    // UploadPhotoModel data = widget.data;
    String eventId = widget.id.toString();
    String uploadUrl;
    if (widget.id != '') {
      uploadUrl = '${widget.apiUrl}/$eventId/upload';
    } else {
      uploadUrl = '${widget.apiUrl}';
    }

    if (_imageFile != null) {
      return SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.file(File(_imageFile!.path)),
              SizedBox(
                height: 20,
              ),
              uploadButton(uploadUrl),
            ],
          ),
        ),
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget uploadButton(uploadUrl) {
    return TextButton(
      onPressed: () async {
        var res = await uploadImage(_imageFile!.path, uploadUrl);
        print(res.statusCode);
        print(res.contentLength);
        if (res.statusCode == 200) {
          if (widget.id == '') {
            UserData data = await ProfileRepository().getUserProfile();
            BlocProvider.of<EventCubit>(context).getAllEvents();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfileView(data: data)));
          }
          AlbumModel data = await EventRepository().getEvent(widget.id);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditEventView(data: data.data)));
        }
      },
      child: const Text('Upload'),
    );
  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      print("Image picker error " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder<void>(
        future: retriveLostData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Text('Picked an image');
            case ConnectionState.done:
              return _previewImage();
            default:
              return const Text('Picked an image');
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Pick Image from gallery',
        child: Icon(Icons.photo_library),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
