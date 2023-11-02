import 'package:omdb_test/features/movies/domain/entities/movie_details.dart';

class MovieDetailsModel extends MovieDetails{
  MovieDetailsModel({required super.title, required super.year, required super.rated, required super.released, required super.runtime, required super.genre, required super.director, required super.writer, required super.actors, required super.plot, required super.language, required super.country, required super.awards, required super.poster, required super.ratings, required super.metascore, required super.imdbRating, required super.imdbVotes, required super.imdbID, required super.type, required super.dvd, required super.boxOffice, required super.production, required super.website, required super.response});



  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      title: json['Title'],
      year: json['Year'],
      rated: json['Rated'],
      released: json['Released'],
      runtime: json['Runtime'],
      genre: json['Genre'],
      director: json['Director'],
      writer: json['Writer'],
      actors: json['Actors'],
      plot: json['Plot'],
      language: json['Language'],
      country: json['Country'],
      awards: json['Awards'],
      poster: json['Poster'],
      ratings: (json['Ratings'] as List).map((rating) {
        return {
          'Source': rating['Source'],
          'Value': rating['Value'],
        };
      }).toList(),
      metascore: json['Metascore'],
      imdbRating: json['imdbRating'],
      imdbVotes: json['imdbVotes'],
      imdbID: json['imdbID'],
      type: json['Type'],
      dvd: json['DVD'],
      boxOffice: json['BoxOffice'],
      production: json['Production'],
      website: json['Website'],
      response: json['Response'],
    );
  }
}