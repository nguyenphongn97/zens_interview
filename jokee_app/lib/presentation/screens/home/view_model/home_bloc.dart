import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/di/dependence_injection.dart';
import '../../../../data/model/jokes_data.dart';
import '../../../../data/services/database_service.dart';
import '../../../../domain/model/joke.dart';
import '../../../../domain/response/joke_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {});
    on<JokesLoad>(_onJokesLoad);
    on<OnJokeVoted>(_onJokeVoted);
  }
  List<JokeData> jokes = [];

  final JokeRepo _jokeRepo = inject<JokeRepo>();

  Future<void> _onJokesLoad(
      JokesLoad event, Emitter<HomeState> emit) async {
    await _jokeRepo.getJokes().then((result){
      jokes = result ?? [];
    });

    if(jokes.isEmpty){
      emit(const JokesLoadFailue(message: "That's all the jokes for today! Come back another day!"));
      return;
    }

    emit(JokesLoaded(joke: jokes.last));
  }

  Future<void> _onJokeVoted(
      OnJokeVoted event, Emitter<HomeState> emit) async {
    final result = await _jokeRepo.voteJoke(jokes.last.id, event.voteJoke);
    if(result == ResponseType.failure){
      //Handle failure
      return;
    }

    jokes.removeLast();

    if(jokes.isEmpty){
      emit(const JokesLoadFailue(message: "That's all the jokes for today! Come back another day!"));
      return;
    }
    emit(JokesLoaded(joke: jokes.last));
  }
}