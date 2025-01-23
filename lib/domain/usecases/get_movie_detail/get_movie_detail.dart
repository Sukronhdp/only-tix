import 'package:only_tix/data/repositories/movie_repository.dart';
import 'package:only_tix/domain/entities/movie_detail.dart';
import 'package:only_tix/domain/entities/result.dart';
import 'package:only_tix/domain/usecases/get_movie_detail/get_movie_detail_param.dart';
import 'package:only_tix/domain/usecases/usecase.dart';

class GetMovieDetail
    implements UseCase<Result<MovieDetail>, GetMovieDetailParam> {
  final MovieRepository _movieRepository;

  GetMovieDetail({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Result<MovieDetail>> call(GetMovieDetailParam params) async {
    var movieDetailResult =
        await _movieRepository.getDetail(id: params.movie.id);

    return switch (movieDetailResult) {
      Success(value: final movieDetail) => Result.success(movieDetail),
      Failed(:final message) => Result.failed(message)
    };
  }
}
