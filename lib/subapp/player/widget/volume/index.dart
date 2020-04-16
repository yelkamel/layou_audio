import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player/bloc/bloc.dart';
import 'package:player/bloc/state.dart';

import 'bar.dart';

class PlayerVolume extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        if (state is PlayerPlaying) {
          return VolumeBar();
        } else if (state is PlayerLoading) {
          return Text('');
        } else if (state is PlayerReady) {
          return Text('');
        } else if (state is PlayerPaused) {
          return VolumeBar();
        } else {
          return Text('SLIDE ERROR');
        }
      },
    );
  }
}
