import '../../data/di/dependence_injection.dart';
import '../../data/model/jokes_data.dart';
import '../../data/services/database_service.dart';
import '../model/joke.dart';

class JokeRepo{
  final DatabaseService _databaseService = inject<DatabaseService>();

  Future<List<JokeData>?> getJokes() async {
    try {
      final result = await _databaseService.getJokes();
      return List<JokeData>.from(result.map(JokeData.fromJson));
    } on Exception catch (_) {
      return null;
    }
  }

  Future<ResponseType> voteJoke(int jokeId, VoteJoke voteJoke) async {
    try {
      return await _databaseService.updateJokes(jokeId, voteJoke == VoteJoke.funny ? 1 : 2);
    } on Exception catch (_) {
      return ResponseType.failure;
    }
  }
}