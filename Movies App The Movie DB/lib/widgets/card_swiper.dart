import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/models_exports.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (movies.length == 0) {
      // ignore: sized_box_for_whitespace
      return Container(
        width: double.infinity,
        height: size.height, //puedes dividirlo *0.5 para que quede mitad mitad
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return Container(
      width: double.infinity,
      height: size.height * 0.55,
      //color: Colors.blueGrey,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.50,
        itemHeight: size.height * 0.48,
        itemBuilder: (_, int index) {
          final movie = movies[index];
          //print(movie.fullPosterImg);

          movie.heroId = 'Swiper-${movie.id}';

          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
