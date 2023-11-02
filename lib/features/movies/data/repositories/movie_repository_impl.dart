import 'package:dartz/dartz.dart';
import 'package:omdb_test/core/errors/failure.dart';
import 'package:omdb_test/core/utils/typedef.dart';
import 'package:omdb_test/features/movies/data/datasouces/movie_data_source.dart';
import 'package:omdb_test/features/movies/domain/entities/movie_details.dart';
import 'package:omdb_test/features/movies/domain/repositories/movie_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/movie_search.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDataSource _movieDataSource;

  const MovieRepositoryImpl(this._movieDataSource);

  @override
  ResultFuture<MovieSearch> getMovies(String query, int? pageNo) async {
    try {
      var response = await _movieDataSource.getMovies(query, pageNo);
      return Right(response);
    } catch (e) {
      if (e is APIException) {
        return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
      } else {
        return Left(ApiFailure(message: e.toString(), statusCode: 550));
      }
    }
  }

  @override
  ResultFuture<MovieDetails> getMoviesById(String movieId) async {
    try {
      var response = await _movieDataSource.getMoviesById(movieId);
      return Right(response);
    } catch (e) {
      if (e is APIException) {
        return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
      } else {
        return Left(ApiFailure(message: e.toString(), statusCode: 550));
      }
    }
  }
}
