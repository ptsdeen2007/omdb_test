part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class GetMovieListEvent extends MovieEvent {
 final String query;
  final int? pageNo;

  const GetMovieListEvent({required this.query, this.pageNo});

  @override
  // TODO: implement props
  List<Object?> get props => [query, pageNo];
}

