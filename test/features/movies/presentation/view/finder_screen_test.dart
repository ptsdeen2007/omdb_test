
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:omdb_test/core/errors/failure.dart';
import 'package:omdb_test/core/screen_arguments.dart';
import 'package:omdb_test/features/movies/data/model/movie_model.dart';
import 'package:omdb_test/features/movies/domain/entities/movie_search.dart';
import 'package:omdb_test/features/movies/presentation/movie_details_bloc/movie_details_bloc.dart';
import 'package:omdb_test/features/movies/presentation/movies_bloc/movie_bloc.dart';
import 'package:omdb_test/features/movies/presentation/view/finder_screen.dart';



class MockMovieBloc extends MockBloc<MovieEvent, MovieState> implements MovieBloc {}

class MockMovieState extends Fake implements MovieState {}

class MockMovieSearch extends Fake implements MovieSearch {}

class MockMovieModel extends Fake implements MovieModel {}

class MockMovieDetailsBloc extends MockBloc<MovieDetailsEvent, MovieDetailsState> implements MovieDetailsBloc {}

class MockMovieDetailsState extends Fake implements MovieDetailsState {}

class MockScreenArguments extends Fake implements ScreenArguments {}

void main() {
  late MovieBloc movieBloc;
  late MovieDetailsBloc movieDetailsBloc;

  setUp(() {
    movieBloc = MockMovieBloc();
    movieDetailsBloc = MockMovieDetailsBloc();
    registerFallbackValue(MockMovieState());
    registerFallbackValue(MockMovieState());
    registerFallbackValue(MockMovieSearch());
    registerFallbackValue(MockMovieModel());
    registerFallbackValue(MockMovieDetailsState());
    registerFallbackValue(MockMovieDetailsState());
    registerFallbackValue(MockScreenArguments());
  });

  tearDown(() {
    movieBloc.close();
    movieDetailsBloc.close();
  });

  testWidgets('FinderScreen should display loading indicator when MovieLoading state is emitted',
          (WidgetTester tester) async {
        when(() => movieBloc.state).thenReturn(MovieLoading());

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<MovieBloc>.value(
              value: movieBloc,
              child: const FinderScreen(),
            ),
          ),
        );

        expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
      });

  testWidgets('FinderScreen should display GridView when MovieLoaded state is emitted',
          (WidgetTester tester) async {
        when(() => movieBloc.state).thenReturn(MovieLoaded(movieSearch: MovieSearch(totalResults: "0",response: "test",search: [])));

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<MovieBloc>.value(
              value: movieBloc,
              child: const FinderScreen(),
            ),
          ),
        );

        expect(find.byType(GridView), findsOneWidget);
      });

  testWidgets('FinderScreen should display error message when MovieFailure state is emitted',
          (WidgetTester tester) async {
        when(() => movieBloc.state).thenReturn(const MovieFailure(ApiFailure(message: "test",statusCode: 500)));

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<MovieBloc>.value(
              value: movieBloc,
              child: const FinderScreen(),
            ),
          ),
        );

        expect(find.byKey(const Key('error_text')), findsOneWidget);
      });

  testWidgets('FinderScreen should display no internet connection message when MovieNoInternetConnection state is emitted',
          (WidgetTester tester) async {
        when(() => movieBloc.state).thenReturn(MovieNoInternetConnection());

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<MovieBloc>.value(
              value: movieBloc,
              child: const FinderScreen(),
            ),
          ),
        );

        expect(find.text('Please check your data connection'), findsOneWidget);
      });

  testWidgets('FinderScreen should display default message when no matching state is emitted',
          (WidgetTester tester) async {
        when(() => movieBloc.state).thenReturn(MockMovieState());

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<MovieBloc>.value(
              value: movieBloc,
              child: const FinderScreen(),
            ),
          ),
        );

        expect(find.text('Please Search your movie'), findsOneWidget);
      });
}