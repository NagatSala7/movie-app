import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_nti_aug/cubits/now_playing_cubit/now_playing_cubit.dart';
import 'package:movie_nti_aug/cubits/upcoming_cubit/upcoming_cubit.dart';
import 'package:movie_nti_aug/cubits/top_rated/top_rated_cubit.dart';

import 'package:movie_nti_aug/screens/movie_details_screen.dart';

class MovieGrid extends StatelessWidget {
  final int itemCount;
  final int Function(int index) movieIdBuilder;
  final String? Function(int index) posterPathBuilder;

  const MovieGrid({
    super.key,
    required this.itemCount,
    required this.movieIdBuilder,
    required this.posterPathBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 10),
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(
                  movieId: movieIdBuilder(index),
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              "https://image.tmdb.org/t/p/w500/${posterPathBuilder(index)}",
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

class NowPlayingMoviesGrid extends StatelessWidget {
  const NowPlayingMoviesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingCubit, NowPlayingState>(
      builder: (context, state) {
        if (state is NowPlayingLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is NowPlayingSuccess) {
          final movies = state.moviews;

          return MovieGrid(
            itemCount: movies.length,
            movieIdBuilder: (index) => movies[index].id,
            posterPathBuilder: (index) =>
            movies[index].posterPath,
          );
        }

        if (state is NowPlayingFailure) {
          return Center(
            child: Text(
              state.messgae,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class UpcomingMoviesGrid extends StatelessWidget {
  const UpcomingMoviesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingCubit, UpcomingState>(
      builder: (context, state) {
        if (state is GetUpcomingLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetUpcomingSuccess) {
          final movies = state.movies;

          return MovieGrid(
            itemCount: movies.length,
            movieIdBuilder: (index) => movies[index].id,
            posterPathBuilder: (index) =>
            movies[index].posterPath,
          );
        }

        if (state is GetUpcomingFailure) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class TopRatedMoviesGrid extends StatelessWidget {
  const TopRatedMoviesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedCubit, TopRatedState>(
      builder: (context, state) {
        if (state is GetTopRatedLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetTopRatedSuccess) {
          final movies = state.movies;

          return MovieGrid(
            itemCount: movies.length,
            movieIdBuilder: (index) => movies[index].id,
            posterPathBuilder: (index) =>
            movies[index].posterPath,
          );
        }

        if (state is GetTopRatedFailure) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}