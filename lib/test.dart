import 'package:flutter/material.dart';
import 'package:player/subapp/player/player_provider.dart';
import 'package:player/subapp/player/widget/status_icon.dart';
import 'package:player/utils/samples.dart';
import 'subapp/player/touchable/play_pause_touchable.dart';
import 'subapp/player/touchable/stop_touchable.dart';
import 'subapp/player/widget/position/index.dart';
import 'subapp/player/widget/volume/index.dart';

class Test extends StatelessWidget {
  Widget _buildPlayerTest(String uri, String testName) {
    return Column(children: [
      PlayerVolume(),
      ListTile(
        title: Text(testName),
        leading: PlayerStopTouchable(),
        subtitle: PlayPauseTouchable(uri: AudioSamples.chakrasMp3),
        trailing: PlayerStatusIcon(),
      ),
      PlayerPosition(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        PlayerProvider(
          child: _buildPlayerTest(AudioSamples.chakrasMp4, 'MP4 Android'),
          playerId: 'player_1',
        ),
        PlayerProvider(
          child: _buildPlayerTest(AudioSamples.chakrasMp3, 'MP3'),
          playerId: 'player_2',
        ),
      ],
    );
  }
}
