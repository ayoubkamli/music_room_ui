import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widgets/player_widget.dart';

typedef OnError = void Function(Exception exception);

const kUrl1 =
    'https://p.scdn.co/mp3-preview/a1514ea0f0c4f729a2ed238ac255f988af195569?cid=3a6f2fd862ef4b5e8e53c3d90edf526d';

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String? localFilePath;
  String? localAudioCacheURI;

  Widget remoteUrl() {
    return PlayerWidget(url: kUrl1);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Duration>.value(
          initialData: const Duration(),
          value: advancedPlayer.onAudioPositionChanged,
        ),
      ],
      child: Scaffold(
        body: remoteUrl(),
      ),
    );
  }
}
