import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:just_audio/just_audio.dart';
import 'package:myapp/playlists/repositories/playlist_repository.dart';
import 'package:myapp/playlists/screens/p_model.dart';
import 'package:myapp/widgets/playlist_player/notifier/play_button_notifier.dart';
import 'package:myapp/widgets/playlist_player/notifier/progress_notifier.dart';
import 'package:myapp/widgets/playlist_player/notifier/repeat_button_notifier.dart';

class PageManager {
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource playlist;

  PageManager() {
    _init();
  }

  void _init() async {
    // getPlaylistData(playlistId);
    _audioPlayer = AudioPlayer();
    setInitialPlaylist();
    _listenForChangesInPlayerState();
    _listenForChangesInPlayerPosition();
    _listenForChangesInBufferedPosition();
    _listenForChangesInTotalDuration();
    _listenForChangesInSequenceState();
  }

  void getPlaylistData(playlistId) async {
    print(
        'page manager ======================================== get playlist $playlistId');
    Response? data = await PlaylistRepository().getOnePlaylist(playlistId);
    if (data != null && data.statusCode == 200) {
      print(
          'page manager ======================================== get playlist dataaaaaa \n ${data.body}');
      Pmodel playlistSongs = Pmodel.fromJson(jsonDecode(data.body));
      List<Tracks> tracks = playlistSongs.data.tracks;
      print('trrrrrraaaaaaccccccckkkkkk' + tracks.toList().toString());
    }
  }

  void setInitialPlaylist() async {
    // final song1 = Uri.parse(
    //     'https://p.scdn.co/mp3-preview/84ecde3a52998ceb70f48750740bdc18665b32f1?cid=3a6f2fd862ef4b5e8e53c3d90edf526d');
    playlist = ConcatenatingAudioSource(children: []);

    await _audioPlayer.setAudioSource(playlist);
  }

  void _listenForChangesInPlayerState() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });
  }

  void _listenForChangesInPlayerPosition() {
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInBufferedPosition() {
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInTotalDuration() {
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void _listenForChangesInSequenceState() {
    _audioPlayer.sequenceStateStream.listen((sequenceState) {
      if (sequenceState == null) return;

      // update current song title
      final currentItem = sequenceState.currentSource;
      final title = currentItem?.tag as String?;
      currentSongTitleNotifier.value = title ?? '';

      // update playlist
      final playlist = sequenceState.effectiveSequence;
      final titles = playlist.map((item) => item.tag as String).toList();
      playlistNotifier.value = titles;

      // update shuffle mode
      isShuffleModeEnabledNotifier.value = sequenceState.shuffleModeEnabled;

      // update previous and next buttons
      if (playlist.isEmpty || currentItem == null) {
        isFirstSongNotifier.value = true;
        isLastSongNotifier.value = true;
      } else {
        isFirstSongNotifier.value = playlist.first == currentItem;
        isLastSongNotifier.value = playlist.last == currentItem;
      }
    });
  }

  void play() async {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  void onRepeatButtonPressed() {
    repeatButtonNotifier.nextState();
    switch (repeatButtonNotifier.value) {
      case RepeatState.off:
        _audioPlayer.setLoopMode(LoopMode.off);
        break;
      case RepeatState.repeatSong:
        _audioPlayer.setLoopMode(LoopMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioPlayer.setLoopMode(LoopMode.all);
    }
  }

  void onPreviousSongButtonPressed() {
    _audioPlayer.seekToPrevious();
  }

  void onNextSongButtonPressed() {
    _audioPlayer.seekToNext();
  }

  void onShuffleButtonPressed() async {
    final enable = !_audioPlayer.shuffleModeEnabled;
    if (enable) {
      await _audioPlayer.shuffle();
    }
    await _audioPlayer.setShuffleModeEnabled(enable);
  }

  void addSong(String newSong) {
    // final songNumber = playlist!.length + 1;
    // const prefix = 'https://www.soundhelix.com/examples/mp3';
    final song = Uri.parse('$newSong.mp3');
    print('$song');
    playlist.add(AudioSource.uri(song, tag: 'Song '));
  }

  void removeSong() {
    final index = playlist.length - 1;
    if (index < 0) return;
    // playlist.removeAt(index);
    playlist.removeRange(0, playlist.length);
  }
}
