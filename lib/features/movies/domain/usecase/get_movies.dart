import 'package:omdb_test/core/usecase/usecase.dart';
import 'package:omdb_test/core/utils/typedef.dart';

import '../entities/movie_search.dart';
import '../repositories/movie_repository.dart';

class GetMovies extends UsecaseWithParams<MovieSearch,GetMovieParams>{
  final MovieRepository _movieRepository;


  const GetMovies(this._movieRepository);

  @override
  ResultFuture<MovieSearch> call(GetMovieParams params) async {
    return await _movieRepository.getMovies(params.searchQuery,params.page);
  }

}
class GetMovieParams{
 final String searchQuery;
  final int? page;

 const GetMovieParams({required this.searchQuery, this.page});
}