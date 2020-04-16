import 'package:equatable/equatable.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();
}

class PlayerInitial extends PlayerState {
  @override
  List<Object> get props => [];
}

class PlayerPlaying extends PlayerState {
  @override
  List<Object> get props => [];
}

class PlayerReady extends PlayerState {
  @override
  List<Object> get props => [];
}

class PlayerLoading extends PlayerState {
  @override
  List<Object> get props => [];
}

class PlayerPaused extends PlayerState {
  @override
  List<Object> get props => [];
}

class PlayerStop extends PlayerState {
  @override
  List<Object> get props => [];
}

class PlayerError extends PlayerState {
  final String message;
  const PlayerError(this.message);

  @override
  List<Object> get props => [message];
}
