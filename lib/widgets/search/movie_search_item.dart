import 'package:flutter/material.dart';

import 'package:movie_nti_aug/models/movie_model.dart';
import 'package:movie_nti_aug/screens/movie_details_screen.dart';

class MovieSearchItem extends StatelessWidget {
  final MovieModel movie;

  const MovieSearchItem({
    super.key,
    required this.movie,
  });

  String _getGenreName(int id) {
    const Map<int, String> genres = {
      28: "Action",
      12: "Adventure",
      16: "Animation",
      35: "Comedy",
      80: "Crime",
      99: "Documentary",
      18: "Drama",
      10751: "Family",
      14: "Fantasy",
      36: "History",
      27: "Horror",
      10402: "Music",
      9648: "Mystery",
      10749: "Romance",
      878: "Science Fiction",
      10770: "TV Movie",
      53: "Thriller",
      10752: "War",
      37: "Western",
    };

    return genres[id] ?? "Action";
  }

  @override
  Widget build(BuildContext context) {
    String year = "";

    if (movie.releaseDate.isNotEmpty &&
        movie.releaseDate.length >= 4) {
      year = movie.releaseDate.substring(0, 4);
    }

    final String categoryName = movie.genreIds.isNotEmpty
        ? _getGenreName(movie.genreIds.first)
        : "Action";

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(
              movieId: movie.id,
            ),
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: movie.posterPath == null
                ? _buildPlaceholder()
                : Image.network(
              "https://image.tmdb.org/t/p/w500${movie.posterPath}",
              width: 95,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) {
                return _buildPlaceholder();
              },
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(
                      Icons.star_border,
                      color: Color(0xffFF8700),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Color(0xffFF8700),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(
                      Icons.confirmation_number_outlined,
                      color: Color(0xff92929D),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      categoryName,
                      style: const TextStyle(
                        color: Color(0xff92929D),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                if (year.isNotEmpty)
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: Color(0xff92929D),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        year,
                        style: const TextStyle(
                          color: Color(0xff92929D),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 4),

                const Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Color(0xff92929D),
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "139 minutes",
                      style: TextStyle(
                        color: Color(0xff92929D),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 95,
      height: 120,
      color: const Color(0xff3A3F47),
      child: const Icon(
        Icons.movie,
        color: Colors.white54,
        size: 30,
      ),
    );
  }
}