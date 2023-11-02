
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:omdb_test/features/movies/data/datasouces/movie_data_source.dart';
import 'package:omdb_test/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:omdb_test/features/movies/domain/repositories/movie_repository.dart';
import 'package:omdb_test/features/movies/domain/usecase/get_movie_by_id.dart';
import 'package:omdb_test/features/movies/domain/usecase/get_movies.dart';
import 'package:omdb_test/features/movies/presentation/movie_details_bloc/movie_details_bloc.dart';
import 'package:omdb_test/features/movies/presentation/movies_bloc/movie_bloc.dart';
import 'package:http/http.dart' as http;

import '../network/network_info.dart';
final sl= GetIt.asNewInstance();

Future<void> init() async{

  //App logic
  sl.registerFactory(() => MovieBloc(getMovies: sl(), networkInfo: sl()));
  sl.registerFactory(() => MovieDetailsBloc(getMovieById: sl(), networkInfo: sl()));

  //Use cases
  sl.registerLazySingleton(() => GetMovies(sl()));
  sl.registerLazySingleton(() => GetMovieById(sl()));

  //Repositories
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(sl()));

  //Data Sources
  sl.registerLazySingleton<MovieDataSource>(() => MovieDataSourceImpl(sl()));

  // Dependencies
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External Dependencies
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

}
