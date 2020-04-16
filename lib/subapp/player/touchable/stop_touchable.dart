import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player/bloc/event.dart';
import 'package:player/bloc/bloc.dart';

class PlayerStopTouchable extends StatelessWidget {
  final Widget child;
  final String uri;

  const PlayerStopTouchable({
    Key key,
    this.uri,
    this.child = const SizedBox(
      height: 50,
      width: 100,
      child: Icon(
        Icons.stop,
        size: 50,
      ),
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerBloc = BlocProvider.of<PlayerBloc>(context);
    return GestureDetector(
      child: child,
      onTap: () {
        playerBloc.add(Stop());
      },
    );
  }
}
