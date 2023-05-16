import 'package:flutter/material.dart';
import 'package:peliculas/providers/movie_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets_export.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    print(moviesProvider.onDisplayMovies);

    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'Peliculas de Cine',
            style: TextStyle(fontSize: 25),
          )),
          elevation: 10,
          actions: [
            IconButton(
                onPressed: () => showSearch(
                    context: context, delegate: MovieSerchDelegate()),
                icon: const Icon(
                  Icons.search_rounded,
                  size: 30,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // tarjetas principales
              CardSwiper(movies: moviesProvider.onDisplayMovies),
              const SizedBox(
                height: 10,
              ),
              // slider de peliculas
              MovieSlider(
                movies: moviesProvider.popularMovies, //populares
                title: 'Populares',
                onNextPage: () => moviesProvider.getPopularMovies(),
              ),
            ],
          ),
        ));
  }
}
