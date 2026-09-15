import 'package:flutter/material.dart';
import 'package:movie_nti_aug/models/review_model.dart';

class MovieReviewsList extends StatelessWidget {
  final List<ReviewModel> reviews;

  const MovieReviewsList({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Text(
          "No reviews available.",
          style: TextStyle(
            color: Color(0xff92929D),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      itemCount: reviews.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
      itemBuilder: (context, index) {
        final review = reviews[index];

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0xff6C5ECF),
                  backgroundImage: review.avatarPath != null
                      ? NetworkImage(
                    review.avatarPath!.startsWith('/http')
                        ? review.avatarPath!.substring(1)
                        : "https://image.tmdb.org/t/p/w185${review.avatarPath}",
                  )
                      : null,
                  child: review.avatarPath == null
                      ? const Icon(
                    Icons.person,
                    color: Colors.white,
                  )
                      : null,
                ),

                const SizedBox(height: 8),

                Text(
                  review.rating != null
                      ? review.rating!.toStringAsFixed(1)
                      : "-",
                  style: const TextStyle(
                    color: Color(0xff0296E5),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    review.author,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    review.content,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xff92929D),
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}