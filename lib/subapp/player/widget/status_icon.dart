import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player/bloc/bloc.dart';
import 'package:player/bloc/state.dart';

final playIcon = Icon(
  Icons.play_arrow,
  size: 30,
);
final pauseIcon = Icon(
  Icons.pause,
  size: 30,
);
final loading = Icon(
  Icons.cloud,
  size: 30,
);

final error = Icon(
  Icons.error,
  size: 30,
);

class PlayerStatusIcon extends StatefulWidget {
  const PlayerStatusIcon({Key key}) : super(key: key);

  @override
  _PlayerStatusIconState createState() => _PlayerStatusIconState();
}

class _PlayerStatusIconState extends State<PlayerStatusIcon> {
  int startLoadingAt = 0;

  int endLoadingAt = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlayerBloc, PlayerState>(
      listener: (context, state) {
        if (state is PlayerLoading) {
          setState(() {
            startLoadingAt = new DateTime.now().millisecondsSinceEpoch;
          });
        } else if (state is PlayerPlaying) {
          setState(() {
            endLoadingAt = new DateTime.now().millisecondsSinceEpoch;
          });
        } else if (state is PlayerStop) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('AUDIO STOPPPER'),
          ));
        }
        if (state is PlayerError) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        } else if (state is PlayerStop) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('AUDIO STOPPPER'),
          ));
        }
      },
      child: Column(children: [
        Text((endLoadingAt - startLoadingAt).toString()),
        BlocBuilder<PlayerBloc, PlayerState>(
          builder: (context, state) {
            if (state is PlayerInitial) {
              return loading;
            } else if (state is PlayerLoading) {
              return loading;
            } else if (state is PlayerReady) {
              return playIcon;
            } else if (state is PlayerPaused) {
              return playIcon;
            } else if (state is PlayerPlaying) {
              return pauseIcon;
            } else {
              return error;
            }
          },
        ),
      ]),
    );
  }
}
