part of 'movie_details_bloc.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();
  @override
  List<Object> get props => [];
}

class MovieDetailsInitial extends MovieDetailsState {

}


class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetails movies;

  const MovieDetailsLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}


class MovieByIdNoInternetConnection extends MovieDetailsLoading {}
class MovieByIdFailure extends MovieDetailsState {
  final Failure _failure;
  String get toMessage=>'Message: ${_failure.message} Code:${_failure.statusCode}';
  const MovieByIdFailure(this._failure);
  @override
  List<Object> get props => [_failure];
}