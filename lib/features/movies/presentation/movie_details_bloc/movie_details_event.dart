part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();
}


class GetMovieByIdEvent extends MovieDetailsEvent {
 final String movieId;


  const GetMovieByIdEvent({required this.movieId});

  @override
  // TODO: implement props
  List<Object?> get props => [movieId];
}