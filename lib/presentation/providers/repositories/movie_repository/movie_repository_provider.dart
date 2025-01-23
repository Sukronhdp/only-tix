import 'package:only_tix/data/repositories/movie_repository.dart';
import 'package:only_tix/data/tmdb/tmdb_movie_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_repository_provider.g.dart';

@riverpod
MovieRepository movieRepository(MovieRepositoryRef ref) =>
    TmdbMovieRepository();
