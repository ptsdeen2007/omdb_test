import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omdb_test/features/movies/domain/entities/movie_details.dart';

import '../../../../core/screen_arguments.dart';
import '../movie_details_bloc/movie_details_bloc.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const route = '/movie_details';

  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    BlocProvider.of<MovieDetailsBloc>(context).add(GetMovieByIdEvent(movieId: args.data));
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title,key: const Key("details_screen")),
          foregroundColor: Colors.black87
      ),
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is MovieDetailsLoaded) return movieUi(state.movies);
          if (state is MovieByIdFailure) {
            return Center(child: Text(state.toMessage));
          }
          if (state is MovieByIdNoInternetConnection) {
            return const Center(
                child: Text('Please check your data connection'));
          }
          return Container();
        },
      ),
    );
  }

  Widget movieUi(MovieDetails jsonMap) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(child: Image.network(jsonMap.poster)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Details', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(jsonMap.year),
                Text(jsonMap.rated),
                Text(jsonMap.released),
                Text(jsonMap.runtime),
                Text(jsonMap.genre),
                Text('Director: ${jsonMap.director}'),
                Text('Writer: ${jsonMap.writer}'),
                Text('Actors: ${jsonMap.actors}'),
                Text(jsonMap.plot),
                Text('Language: ${jsonMap.language}'),
                Text('Country: ${jsonMap.country}'),
                Text('Awards: ${jsonMap.awards}'),
                const Divider(),
                const Text('Ratings:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                for (var rating in jsonMap.ratings)
                  Text('${rating['Source']}: ${rating['Value']}'),
                Text('Metascore: ${jsonMap.metascore}'),
                Text('IMDb Rating: ${jsonMap.imdbRating}'),
                Text('IMDb Votes: ${jsonMap.imdbVotes}'),
                Text('IMDb ID: ${jsonMap.imdbID}'),
                Text('Type: ${jsonMap.type}'),
                Text('DVD: ${jsonMap.dvd}'),
                Text('Box Office: ${jsonMap.boxOffice}'),
                Text('Production: ${jsonMap.production}'),
                Text('Website: ${jsonMap.website}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
