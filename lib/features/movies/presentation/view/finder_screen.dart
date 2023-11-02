import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omdb_test/features/movies/data/model/movie_model.dart';
import 'package:omdb_test/features/movies/domain/entities/movie_search.dart';
import 'package:omdb_test/features/movies/presentation/view/widget/movie_finder.dart';

import '../../../../core/screen_arguments.dart';
import '../movies_bloc/movie_bloc.dart';
import 'movie_details_screen.dart';

class FinderScreen extends StatelessWidget {
  static const route = '/';

  const FinderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MovieFinder(),
      body: BlocConsumer<MovieBloc, MovieState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is MovieLoaded) return gridViewUi(state.movieSearch);
          if (state is MovieFailure) {
            return Center(key: const Key('error_text'),child: Text(state.toMessage),);
          }
          if (state is MovieNoInternetConnection) {
            return const Center(
                child: Text('Please check your data connection'));
          }
          return Center(
              child: Text(
            'Please Search your movie',
            style: Theme.of(context).textTheme.bodyLarge,
          )); // it will not render
        },
      ),
    );
  }

  Widget gridViewUi(MovieSearch movieSearch) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .78 // Number of columns in the grid
          ),
      itemCount: movieSearch.search.length,
      itemBuilder: (context, index) {
        final MovieModel movie = movieSearch.search[index];
        return GestureDetector(
          key: Key('tile $index'),
          onTap: () {
            Navigator.pushNamed(context, MovieDetailsScreen.route,
                arguments:
                    ScreenArguments(title: movie.title, data: movie.imdbID));
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Image.network(movie.poster,
                      height: 150.0, width: 100.0, fit: BoxFit.cover),
                  Text(movie.year),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      movie.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
