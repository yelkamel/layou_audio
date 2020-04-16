import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_sound/flauto.dart';
import 'package:flutter_sound/flutter_sound_player.dart';

import 'event.dart';
import 'state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final String playerId;

  t_CODEC codec = t_CODEC.DEFAULT;
  Uint8List data;

  FlutterSoundPlayer player = FlutterSoundPlayer();

  PlayerBloc({this.playerId});

  StreamSubscription<PlayStatus> stateSubscription;

  StreamController<PlayStatus> stateController =
      StreamController<PlayStatus>.broadcast();

  Stream<PlayStatus> get getStateStream {
    return stateController.stream;
  }

  @override
  PlayerState get initialState => PlayerInitial();

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is Initilisation) {
      yield* mapInitToState();
    }
    if (event is Play) {
      yield* mapPlayToState(event);
    }
    if (event is Stop) {
      yield* mapStopToState();
    }
    if (event is SeekTo) {
      yield* mapSeekToState(event);
    }
  }

  Stream<PlayerState> mapInitToState() async* {
    yield PlayerLoading();
    await hackForUpdateState();
    await player.release();
    await player.initialize();
    await player.setSubscriptionDuration(0.01);
    yield PlayerReady();
  }

  Stream<PlayerState> mapSeekToState(SeekTo event) async* {
    await player.seekToPlayer(event.milliseconds);
    yield PlayerPlaying();
  }

  Stream<PlayerState> mapStopToState() async* {
    await player.stopPlayer();
    stateController.add(PlayStatus.zero());
    yield PlayerReady();
  }

  Stream<PlayerState> mapPlayToState(Play event) async* {
    if (player.isPlaying) {
      await player.pausePlayer();
      yield PlayerPaused();
      return;
    }

    if (player.isPaused) {
      await player.resumePlayer();
      yield PlayerPlaying();
      return;
    }

    yield PlayerLoading();
    await hackForUpdateState();
    await player.startPlayer(
      event.uri,
      whenFinished: () {
        print('I hope you enjoyed listening to this song');
      },
    );
    stateSubscription = player.onPlayerStateChanged.listen((e) {
      if (e != null) {
        stateController.add(e);
      }
    });
    yield PlayerPlaying();
  }

  Future hackForUpdateState() {
    // HACKAGE DE GAME
    // Normalement le Future.delayed n'est pas censé être necessaire 😅
    // mais le bloc ne se s'étais pas mis à jour, c'est la seul solution
    // que j'ai trouvé à l'insctint  😁
    return Future.delayed(Duration(milliseconds: 100), () {});
  }

  void release() {
    stateController.close();
    player.release();
  }
}
