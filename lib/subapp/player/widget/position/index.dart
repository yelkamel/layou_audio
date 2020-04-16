import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player/bloc/bloc.dart';
import 'package:player/bloc/state.dart';
import 'package:player/subapp/player/widget/position/bar.dart';

class PlayerPosition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        if (state is PlayerPlaying) {
          return SliderBar();
        } else if (state is PlayerLoading) {
          return Text('Chargement...');
        } else if (state is PlayerReady) {
          return Text('');
        } else if (state is PlayerPaused) {
          return SliderBar();
        } else {
          return Text('SLIDE ERROR');
        }
      },
    );
  }
}
