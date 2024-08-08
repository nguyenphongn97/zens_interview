part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
} 

class JokesLoaded extends HomeState {
  const JokesLoaded({required this.joke});
  final JokeData joke;

  @override
  List<Object> get props => [identityHashCode(this), joke];
}

class JokesLoadFailue extends HomeState {
  const JokesLoadFailue({required this.message});
  final String message;
  
  @override
  List<Object> get props => [];
}