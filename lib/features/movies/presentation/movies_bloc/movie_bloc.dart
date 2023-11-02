
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omdb_test/core/errors/failure.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/entities/movie_search.dart';
import '../../domain/usecase/get_movies.dart';
import 'package:stream_transform/stream_transform.dart';

part 'movie_event.dart';

part 'movie_state.dart';

const _duration =  Duration(milliseconds: 300);
EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovies getMovies;
  final NetworkInfo networkInfo;


  MovieBloc({required this.getMovies,required this.networkInfo}) : super(MovieInitial()) {
    on<GetMovieListEvent>(transformer: debounce(_duration),(event, emit) async {
      if(event.query.isNotEmpty){
        emit(MovieLoading());
        if(await networkInfo.isConnected){
          var result = await getMovies(
              GetMovieParams(searchQuery: event.query, page: event.pageNo));
          result.fold((failure) => emit(MovieFailure(failure)), (r) =>
              emit(MovieLoaded(movieSearch: r)));
        }else{
          emit(MovieNoInternetConnection());
        }
      }else{
        emit(MovieInitial());
      }

    });
  }
}
