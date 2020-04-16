import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:player/bloc/bloc.dart';

class VolumeBar extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final position = useState(1.0);
    final playerBloc = BlocProvider.of<PlayerBloc>(context);
    return Container(
      padding: EdgeInsets.all(10),
      height: 50.0,
      width: 400,
      child: Slider(
        value: position.value,
        min: 0.0,
        max: 1,
        activeColor: Colors.orangeAccent,
        onChanged: (value) async {
          position.value = value;
          await playerBloc.player.setVolume(value);
        },
      ),
    );
  }
}
