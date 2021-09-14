import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime_type/mime_type.dart';

class UploadPhoto extends StatefulWidget {
  final String title;

  const UploadPhoto({Key? key, required this.title}) : super(key: key);

  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  XFile? _imageFile;
  final String uploadUrl = '$eventUrl/6140c0dc71403a001e6b1f18/upload';
  final ImagePicker _picker = ImagePicker();

  Future<StreamedResponse> uploadImage(filepath, url) async {
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('Token');
    String bearerToken = 'Bearer $token';
    print('url $uploadUrl : filepath--> $filepath');
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
      print('response.body ' + response.body);
      print(response.headers);
      print(filepath);
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
    if (_imageFile != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.file(File(_imageFile!.path)),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                var res = await uploadImage(_imageFile!.path, uploadUrl);
                print(res.statusCode);
              },
              child: const Text('Upload'),
            )
          ],
        ),
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
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
