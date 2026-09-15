import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_nti_aug/cubits/home_cubit/home_cubit.dart';
import 'package:movie_nti_aug/cubits/now_playing_cubit/now_playing_cubit.dart';
import 'package:movie_nti_aug/cubits/top_rated/top_rated_cubit.dart';
import 'package:movie_nti_aug/cubits/upcoming_cubit/upcoming_cubit.dart';

import 'package:movie_nti_aug/widgets/home/home_search_bar.dart';
import 'package:movie_nti_aug/widgets/home/home_carousel.dart';
import 'package:movie_nti_aug/widgets/home/home_category_tabs.dart';
import 'package:movie_nti_aug/widgets/home/movie_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<HomeCubit>().getCarouselMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DefaultTabController(
        length: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What do you want to watch?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            const HomeSearchBar(),

            const SizedBox(height: 24),

            const HomeCarousel(),

            const HomeCategoryTabs(),

            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                  NowPlayingCubit()..getNowPlaying(),
                ),
                BlocProvider(
                  create: (context) =>
                  UpcomingCubit()..getUpcomingMovies(),
                ),
                BlocProvider(
                  create: (context) =>
                  TopRatedCubit()..getTopRated(),
                ),
              ],
              child: const Expanded(
                child: TabBarView(
                  children: [
                    NowPlayingMoviesGrid(),
                    UpcomingMoviesGrid(),
                    TopRatedMoviesGrid(),

                    Center(
                      child: Text(
                        "Now playing",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}