import 'package:omdb_test/core/utils/typedef.dart';
import 'package:omdb_test/features/movies/domain/entities/movie_details.dart';
import 'package:omdb_test/features/movies/domain/repositories/movie_repository.dart';

import '../../../../core/usecase/usecase.dart';

class GetMovieById extends UsecaseWithParams<MovieDetails,GetMovieByIdParams>{
  final MovieRepository _movieRepository;

  const GetMovieById(this._movieRepository);

  @override
  ResultFuture<MovieDetails> call(GetMovieByIdParams params) async {
   return await _movieRepository.getMoviesById(params.id);
  }


}
class GetMovieByIdParams{
  final String id;
  const GetMovieByIdParams({required this.id});
}