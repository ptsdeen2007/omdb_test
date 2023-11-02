import 'package:omdb_test/core/utils/typedef.dart';
import 'package:omdb_test/features/movies/domain/entities/movie_details.dart';

import '../entities/movie_search.dart';

abstract class MovieRepository{
  ResultFuture<MovieSearch> getMovies(String query, int? pageNo);
  ResultFuture<MovieDetails> getMoviesById(String movieId);
}