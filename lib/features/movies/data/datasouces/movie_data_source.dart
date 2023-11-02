

import 'dart:convert';

import 'package:omdb_test/core/const/app_const.dart';
import 'package:omdb_test/features/movies/data/model/movie_details_model.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/movie_details.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/movie_search.dart';
import '../model/movie_search_model.dart';

abstract class MovieDataSource{
  Future<MovieSearch> getMovies(String query, int? pageNo);
  Future<MovieDetails> getMoviesById(String movieId);
}

class MovieDataSourceImpl implements MovieDataSource{
  final http.Client _client;

  MovieDataSourceImpl(this._client);

  @override
  Future<MovieSearch> getMovies(String query, int? pageNo) =>getMoviesFromUrl('http://www.omdbapi.com/?s=$query&page=${pageNo??""}&apikey=${AppConst.apiKey}');

  @override
  Future<MovieDetails> getMoviesById(String movieId) =>getMoviesByIdFromUrl('http://www.omdbapi.com/?i=$movieId&apikey=${AppConst.apiKey}');

  Future<MovieSearch> getMoviesFromUrl(String url) async {
    final response=await _client.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw APIException(message: response.body, statusCode: response.statusCode);
    }
    var decoded = json.decode(response.body);
    if(decoded['Response']=='False'){
      throw const APIException(message: "Result Not fount", statusCode: 404);
    }
    return MovieSearchModel.fromJson(decoded);
  }

  Future<MovieDetailsModel> getMoviesByIdFromUrl(String url) async {
    final response=await _client.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw APIException(message: response.body, statusCode: response.statusCode);
    }
    var decoded = json.decode(response.body);
    if(decoded['Response']=='False'){
      throw const APIException(message: "Result Not fount", statusCode: 404);
    }
    return MovieDetailsModel.fromJson(decoded);
  }

}