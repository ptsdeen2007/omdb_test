
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omdb_test/features/movies/domain/entities/movie_details.dart';
import 'package:omdb_test/features/movies/domain/usecase/get_movie_by_id.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';

part 'movie_details_event.dart';

part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieById getMovieById;
  final NetworkInfo networkInfo;

  MovieDetailsBloc({required this.getMovieById, required this.networkInfo})
      : super(MovieDetailsInitial()) {
    on<GetMovieByIdEvent>((event, emit) async {
      emit(MovieDetailsLoading());
      if (await networkInfo.isConnected) {
        var result = await getMovieById(GetMovieByIdParams(id: event.movieId));
        result.fold((failure) => emit(MovieByIdFailure(failure)),
            (r) => emit(MovieDetailsLoaded(movies: r)));
      } else {
        emit(MovieByIdNoInternetConnection());
      }
    });
  }
}
