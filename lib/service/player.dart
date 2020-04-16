import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flauto.dart';
import 'package:flutter_sound/flutter_sound_player.dart';

enum PlayerStatus { Waiting, Loading, Playing, Paused, Error, Stop }

class Player extends ChangeNotifier {
  t_CODEC codec = t_CODEC.DEFAULT;
  Uint8List data;

  FlutterSoundPlayer player = FlutterSoundPlayer();
  StreamSubscription<PlayStatus> stateSubscription;
  StreamController<PlayStatus> stateStateController =
      StreamController<PlayStatus>.broadcast();
  StreamController<PlayerStatus> statusController =
      StreamController<PlayerStatus>.broadcast();
  PlayStatus state;
  PlayerStatus status = PlayerStatus.Waiting;

  Player() {
    initPlayer();
  }

  Future<void> initPlayer() async {
    print('initPlayer');
    await player.initialize();
    await player.setSubscriptionDuration(0.01);
    statusController.add(PlayerStatus.Waiting);
  }

  Stream<PlayerStatus> get getStatusStream {
    return statusController.stream;
  }

  Stream<PlayStatus> get getStateStream {
    return stateStateController.stream;
  }

  Future<void> seekToPlayer(double value) async {
    await player.seekToPlayer(value.toInt());
  }

  void addListeners() {
    cancelPlayerSubscriptions();
    stateSubscription = player.onPlayerStateChanged.listen((e) {
      if (e != null) {
        stateStateController.add(e);

        final PlayerStatus currentStatus =
            Helper.getPlayerStatusFromPlayer(player);
        statusController.add(currentStatus);
        status = currentStatus;
        // notifyListeners();
      }
    });
  }

  void onPlayPausedPress(String uri) {
    print("onPlayPausedPress $status");

    if (status == PlayerStatus.Loading) {
      return;
    }

    if (status == PlayerStatus.Paused) {
      player.resumePlayer();
    }
    if (status == PlayerStatus.Playing) {
      player.pausePlayer();
    }
    statusController.add(PlayerStatus.Loading);
    status = PlayerStatus.Loading;
    play(uri);
  }

  void play(String uri) async {
    if (status == PlayerStatus.Stop) {
      await initPlayer();
    }

    await startPlayer(uri);
    print("startPlayer");
    addListeners();
  }

  startPlayer(String uri, {bool hasRemoteControl = true}) async {
    print("path $uri");
    await player.startPlayer(
      uri,
      whenFinished: () {
        print('I hope you enjoyed listening to this song');
      },
    );
    return;

/*
    final track = Track(
        trackPath: uri,
        dataBuffer: data,
        codec: codec,
        trackTitle: "Evolmum",
        trackAuthor: "Test Test",
        albumArtUrl:
            "https://secureservercdn.net/160.153.137.99/8vl.9b3.myftpupload.com/wp-content/uploads/2019/03/evolum.png");

    TrackPlayer f = player as TrackPlayer;
    await f.startPlayerFromTrack(
      track,
      whenFinished: () {
        print('ITrackto this song');
      },
      onSkipBackward: () {
        print('Skip backward');
      },
      onSkipForward: () {
        print('Skip forward');
      },
    );
    */
  }

  void finish() async {
    try {
      await player.release();
    } catch (e) {
      print('Released unsuccessful');
      print(e);
    }
    status = PlayerStatus.Stop;
    statusController.add(status);
  }

  void cancelPlayerSubscriptions() {
    if (stateSubscription != null) {
      stateSubscription.cancel();
      stateSubscription = null;
    }
  }
}

class Helper {
  static PlayerStatus getPlayerStatusFromPlayer(FlutterSoundPlayer player) {
    if (player != null) {
      if (player.isPlaying) return PlayerStatus.Playing;
      if (player.isPaused) return PlayerStatus.Paused;
    }

    return PlayerStatus.Error;
  }
}
