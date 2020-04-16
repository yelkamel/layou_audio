import 'package:equatable/equatable.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class Initilisation extends PlayerEvent {}

class Play extends PlayerEvent {
  final String uri;
  const Play(this.uri);
  @override
  List<Object> get props => [uri];
}

class Stop extends PlayerEvent {}

class SeekTo extends PlayerEvent {
  final int milliseconds;
  const SeekTo(this.milliseconds);
  @override
  List<Object> get props => [milliseconds];
}
