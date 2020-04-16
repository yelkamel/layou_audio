import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:player/bloc/bloc.dart';
import 'package:player/bloc/deleguate.dart';
import 'package:player/bloc/event.dart';

class PlayerProvider extends StatefulWidget {
  final Widget child;
  final String playerId;
  const PlayerProvider({Key key, this.playerId, this.child}) : super(key: key);

  @override
  _PlayerProviderState createState() => _PlayerProviderState();
}

class _PlayerProviderState extends State<PlayerProvider> {
  PlayerBloc playerBloc;

  @override
  void initState() {
    super.initState();
    playerBloc = PlayerBloc(playerId: widget.playerId);
  }

  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = PlayerDelegate();
    return BlocProvider<PlayerBloc>(
      create: (_) => playerBloc..add(Initilisation()),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    playerBloc.release();
    super.dispose();
  }
}
