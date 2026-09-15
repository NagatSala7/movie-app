import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_nti_aug/cubits/home_cubit/home_cubit.dart';
import 'package:movie_nti_aug/screens/movie_details_screen.dart';

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeCarouselMovieLoading) {
          return const SizedBox(
            height: 310,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is HomeCarouselMovieSuccess) {
          final movies = state.movies;

          return SizedBox(
            height: 310,
            child: CarouselSlider.builder(
              options: CarouselOptions(
                viewportFraction: 0.4,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index, realIndex) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(
                          movieId: movies[index].id,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500/${movies[index].posterPath}",
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          );
        }

        return const SizedBox(
          height: 310,
          child: Center(
            child: Text(
              "There is an unknown error",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}