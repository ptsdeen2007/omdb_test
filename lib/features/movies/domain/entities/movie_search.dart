import 'package:omdb_test/features/movies/data/model/movie_model.dart';


class MovieSearch {
  final List<MovieModel> search;
  final String totalResults;
  final String response;

  MovieSearch({
    required this.search,
    required this.totalResults,
    required this.response,
  });


}