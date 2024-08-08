import 'package:get_it/get_it.dart';

import '../../domain/response/joke_repo.dart';
import '../services/database_service.dart';

GetIt inject = GetIt.instance;

Future<void> initDependence() async {
  inject..registerFactory<DatabaseService>(() => DatabaseService.instance)
  ..registerFactory<JokeRepo>(JokeRepo.new);
}