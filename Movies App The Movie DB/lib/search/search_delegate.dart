import 'package:flutter/material.dart';
import 'package:peliculas/models/models_exports.dart';
import 'package:peliculas/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieSerchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  Widget _emptyContainer() => Container(
          child: const Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black38,
          size: 130,
        ),
      ));

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return _emptyContainer();
        }
        final movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItem(movie: movies[index]),
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
          fit: BoxFit.contain,
          width: 50,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        print(movie.title);
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
