// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';

// class PlaylistManager {
//   final progressNotifier = ValueNotifier<ProgressBarState>(
//     ProgressBarState(
//       current: Duration.zero,
//       bufferd: Duration.zero,
//       total: Duration.zero,
//     ),
//   );
//   final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

//   static const url =
//       'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';

//   late AudioPlayer _audioPlayer;

//   PlaylistManager() {
//     _init();
//   }

//   void _init() async {
//     _audioPlayer = AudioPlayer();
//     await _audioPlayer.setUrl(url);
//   }

//   void play() {
//     print('play');
//     _audioPlayer.play();
//   }

//   void pause() {
//     _audioPlayer.pause();
//   }

//   void dispose() {
//     _audioPlayer.dispose();
//   }
// }

// class ProgressBarState {
//   final Duration current;

//   final Duration bufferd;

//   final Duration total;

//   ProgressBarState({
//     required this.current,
//     required this.bufferd,
//     required this.total,
//   });
// }

// enum ButtonState { paused, playing, loading }
