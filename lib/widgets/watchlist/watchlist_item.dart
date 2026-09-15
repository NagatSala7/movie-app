import 'package:flutter/material.dart';

import 'package:movie_nti_aug/models/movie_details_model.dart';
import 'package:movie_nti_aug/screens/movie_details_screen.dart';

class WatchlistItem extends StatelessWidget {
  final MovieDetailsModel movie;

  const WatchlistItem({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    String year = "";

    if (movie.releaseDate.isNotEmpty &&
        movie.releaseDate.length >= 4) {
      year = movie.releaseDate.substring(0, 4);
    }

    String genre = "";

    if (movie.genres.isNotEmpty) {
      genre = movie.genres.first.name;
    }

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
              errorBuilder: (
                  context,
                  error,
                  stackTrace,
                  ) {
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

                const SizedBox(height: 8),

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

                const SizedBox(height: 6),

                if (genre.isNotEmpty)
                  Row(
                    children: [
                      const Icon(
                        Icons.confirmation_number_outlined,
                        color: Color(0xff92929D),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          genre,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xff92929D),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 6),

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

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Color(0xff92929D),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${movie.runtime} minutes",
                      style: const TextStyle(
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
      ),
    );
  }
}