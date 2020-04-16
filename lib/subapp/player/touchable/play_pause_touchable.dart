import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player/bloc/event.dart';
import 'package:player/bloc/bloc.dart';

class PlayPauseTouchable extends StatelessWidget {
  final Widget child;
  final String uri;

  const PlayPauseTouchable({
    Key key,
    this.uri,
    this.child = const SizedBox(
      height: 50,
      width: 100,
      child: const RaisedButton(
        child: Text('PlayPause'),
      ),
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerBloc = BlocProvider.of<PlayerBloc>(context);
    return GestureDetector(
      child: child,
      onTap: () {
        playerBloc.add(Play(uri));
      },
    );
  }
}
