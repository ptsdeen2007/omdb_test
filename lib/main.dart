import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omdb_test/features/movies/presentation/movie_details_bloc/movie_details_bloc.dart';
import 'package:omdb_test/features/movies/presentation/movies_bloc/movie_bloc.dart';
import 'package:omdb_test/features/movies/presentation/view/finder_screen.dart';


import 'core/servieces/injection_container.dart';
import 'core/servieces/my_global_oberver.dart';
import 'features/movies/presentation/view/movie_details_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  Bloc.observer = AppGlobalObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider( create: (context) => sl<MovieBloc>()..add(GetMovieListEvent(query: 'ghost'))),
        BlocProvider( create: (context) => sl<MovieBloc>()),
        BlocProvider( create: (context) => sl<MovieDetailsBloc>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            foregroundColor: Colors.white
          )
        ),
        initialRoute: FinderScreen.route,
        routes: {
          FinderScreen.route: (context) => const FinderScreen(),
          MovieDetailsScreen.route: (context) => const MovieDetailsScreen(),
        },
      ),
    );
  }
}

