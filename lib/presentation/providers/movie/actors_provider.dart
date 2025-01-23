import 'package:only_tix/domain/entities/actor.dart';
import 'package:only_tix/domain/entities/result.dart';
import 'package:only_tix/domain/usecases/get_actors/get_actors.dart';
import 'package:only_tix/domain/usecases/get_actors/get_actors_param.dart';
import 'package:only_tix/presentation/providers/usecases/get_actors_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'actors_provider.g.dart';

@riverpod
Future<List<Actor>> actors(ActorsRef ref, {required int movieId}) async {
  GetActors getActors = ref.read(getActorsProvider);

  var actorsResult = await getActors(GetActorsParam(movieId: movieId));

  return switch (actorsResult) {
    Success(value: final actors) => actors,
    Failed(message: _) => const []
  };
}
