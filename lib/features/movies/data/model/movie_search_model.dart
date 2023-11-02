import 'package:omdb_test/features/movies/domain/entities/movie_search.dart';

import 'movie_model.dart';

class MovieSearchModel extends MovieSearch{
  MovieSearchModel({required super.search, required super.totalResults, required super.response});

  factory MovieSearchModel.fromJson(Map<String, dynamic> json) {
    List<MovieModel> search = (json['Search'] as List).map((movieJson) {
      return MovieModel.fromJson(movieJson);
    }).toList();

    return MovieSearchModel(
      search: search,
      totalResults: json['totalResults'],
      response: json['Response'],
    );
  }

}