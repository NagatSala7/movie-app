import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:movie_nti_aug/cubits/movie_details_cubit/movie_details_cubit.dart';
import 'package:movie_nti_aug/models/movie_details_model.dart';

import 'package:movie_nti_aug/widgets/movie_details/movie_info_row.dart';
import 'package:movie_nti_aug/widgets/movie_details/movie_details_tabs.dart';
import 'package:movie_nti_aug/widgets/movie_details/movie_reviews_list.dart';
import 'package:movie_nti_aug/widgets/movie_details/movie_cast_grid.dart';
import 'package:movie_nti_aug/widgets/movie_details/rate_movie_bottom_sheet.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

  @override
  State<MovieDetailsScreen> createState() =>
      _MovieDetailsScreenState();
}

class _MovieDetailsScreenState
    extends State<MovieDetailsScreen> {
  int selectedTabIndex = 0;
  bool isSaved = false;

  final Box<MovieDetailsModel> watchlistBox =
  Hive.box<MovieDetailsModel>('watchlistBox');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      MovieDetailsCubit()
        ..getMovieDetails(widget.movieId),
      child: Scaffold(
        backgroundColor: const Color(0xff242A32),
        body: SafeArea(
          child: BlocBuilder<
              MovieDetailsCubit,
              MovieDetailsState>(
            builder: (context, state) {
              if (state is MovieDetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff0296E5),
                  ),
                );
              }

              if (state is MovieDetailsFailure) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              }

              if (state is MovieDetailsSuccess) {
                final movie = state.movie;

                isSaved =
                    watchlistBox.containsKey(movie.id);

                String year = "";

                if (movie.releaseDate.isNotEmpty &&
                    movie.releaseDate.length >= 4) {
                  year = movie.releaseDate.substring(0, 4);
                }

                final String genres =
                movie.genres.isNotEmpty
                    ? movie.genres.first.name
                    : "";

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () =>
                                  Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),

                            const Expanded(
                              child: Center(
                                child: Text(
                                  "Detail",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: () async {
                                if (isSaved) {
                                  await watchlistBox
                                      .delete(movie.id);

                                  setState(() {
                                    isSaved = false;
                                  });

                                  ScaffoldMessenger.of(
                                      context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Removed from Watchlist",
                                      ),
                                      duration:
                                      Duration(
                                        seconds: 1,
                                      ),
                                    ),
                                  );
                                } else {
                                  await watchlistBox.put(
                                    movie.id,
                                    movie,
                                  );

                                  setState(() {
                                    isSaved = true;
                                  });

                                  ScaffoldMessenger.of(
                                      context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Added to Watchlist",
                                      ),
                                      duration:
                                      Duration(
                                        seconds: 1,
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(
                                isSaved
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: isSaved
                                    ? const Color(0xff0296E5)
                                    : Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 270,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ClipRRect(
                              borderRadius:
                              const BorderRadius.only(
                                bottomLeft:
                                Radius.circular(16),
                                bottomRight:
                                Radius.circular(16),
                              ),
                              child:
                              movie.backdropPath != null
                                  ? Image.network(
                                "https://image.tmdb.org/t/p/w780${movie.backdropPath}",
                                width:
                                double.infinity,
                                height: 210,
                                fit: BoxFit.cover,
                              )
                                  : Container(
                                width:
                                double.infinity,
                                height: 210,
                                color: const Color(
                                    0xff3A3F47),
                              ),
                            ),

                            Positioned(
                              left: 28,
                              top: 150,
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(16),
                                child:
                                movie.posterPath != null
                                    ? Image.network(
                                  "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                                  width: 95,
                                  height: 120,
                                  fit: BoxFit.cover,
                                )
                                    : Container(
                                  width: 95,
                                  height: 120,
                                  color: const Color(
                                      0xff3A3F47),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 12,
                              bottom: 70,
                              child: GestureDetector(
                                onTap: () =>
                                    showRateMovieBottomSheet(
                                      context,
                                      movie.id,
                                    ),
                                child: Container(
                                  padding:
                                  const EdgeInsets
                                      .symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                        0xff252836)
                                        .withOpacity(0.8),
                                    borderRadius:
                                    BorderRadius
                                        .circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize:
                                    MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.star_border,
                                        color: Color(
                                            0xffFF8700),
                                        size: 16,
                                      ),
                                      const SizedBox(
                                          width: 4),
                                      Text(
                                        movie.voteAverage
                                            .toStringAsFixed(
                                            1),
                                        style:
                                        const TextStyle(
                                          color: Color(
                                              0xffFF8700),
                                          fontSize: 12,
                                          fontWeight:
                                          FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              left: 140,
                              top: 222,
                              right: 20,
                              child: Text(
                                movie.title,
                                maxLines: 2,
                                overflow:
                                TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      MovieInfoRow(
                        year: year,
                        runtime:
                        movie.runtime.toString(),
                        genre: genres,
                      ),

                      const SizedBox(height: 24),

                      MovieDetailsTabs(
                        selectedTabIndex:
                        selectedTabIndex,
                        onTabSelected: (index) {
                          setState(() {
                            selectedTabIndex = index;
                          });
                        },
                      ),

                      const SizedBox(height: 24),

                      if (selectedTabIndex == 0)
                        _buildAboutMovie(
                          movie.overview,
                        )
                      else if (selectedTabIndex == 1)
                        MovieReviewsList(
                          reviews: state.reviews,
                        )
                      else
                        MovieCastGrid(
                          cast: state.cast,
                        ),

                      const SizedBox(height: 30),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAboutMovie(String overview) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Text(
        overview.isEmpty
            ? "No description available."
            : overview,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.6,
        ),
      ),
    );
  }
}