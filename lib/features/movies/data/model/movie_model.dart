import 'package:omdb_test/features/movies/domain/entities/movie.dart';

class MovieModel extends Movie{
  MovieModel({required super.title, required super.year, required super.imdbID, required super.type, required super.poster});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['Title'],
      year: json['Year'],
      imdbID: json['imdbID'],
      type: json['Type'],
      poster: json['Poster'],
    );
  }

}