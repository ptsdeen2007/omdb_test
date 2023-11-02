part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();
  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final MovieSearch movieSearch;

 const MovieLoaded({required this.movieSearch});
  @override
  List<Object> get props => [movieSearch];
}
class MovieNoInternetConnection extends MovieState {}
class MovieFailure extends MovieState {
  final Failure _failure;
  String get toMessage=>'Message: ${_failure.message} Code:${_failure.statusCode}';

  const MovieFailure(this._failure);
  @override
  List<Object> get props => [_failure];
}
