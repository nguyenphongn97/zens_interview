part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class JokesLoad extends HomeEvent {}

class OnJokeVoted extends HomeEvent {
  const OnJokeVoted({required this.voteJoke});
  final VoteJoke voteJoke;

  List<Object> get prop => [];
}