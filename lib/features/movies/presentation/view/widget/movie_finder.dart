import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../movies_bloc/movie_bloc.dart';

class MovieFinder extends StatelessWidget implements PreferredSizeWidget {
  const MovieFinder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySearchBar(
      key: const Key("search"),
      title: const Text('OMDB Search'),
      onSearch: (query) {
        BlocProvider.of<MovieBloc>(context)
            .add(GetMovieListEvent(query: query));
      },
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56);
}
