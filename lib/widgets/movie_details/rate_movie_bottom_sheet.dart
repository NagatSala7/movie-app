import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_nti_aug/services/tmdb_rating_service.dart';

void showRateMovieBottomSheet(
    BuildContext context,
    int movieId,
    ) {
  double currentRating = 5.0;
  bool isSubmitting = false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.3),
    builder: (sheetContext) {
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              margin: const EdgeInsets.only(
                bottom: 24,
                left: 16,
                right: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: isSubmitting
                          ? null
                          : () => Navigator.pop(sheetContext),
                      child: const Icon(
                        Icons.close,
                        color: Color(0xff92929D),
                        size: 22,
                      ),
                    ),
                  ),

                  const Text(
                    "Rate this movie",
                    style: TextStyle(
                      color: Color(0xFF4E4B66),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    currentRating.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Color(0xff121312),
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 12),

                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor:
                      const Color(0xffFF8700),
                      inactiveTrackColor:
                      const Color(0xffEBEBEF),
                      thumbColor: Colors.white,
                      overlayColor:
                      const Color(0x29FF8700),
                      thumbShape:
                      const RoundSliderThumbShape(
                        enabledThumbRadius: 14,
                        elevation: 4,
                      ),
                      trackHeight: 12,
                    ),
                    child: Slider(
                      value: currentRating,
                      min: 0.5,
                      max: 10.0,
                      divisions: 19,
                      onChanged: isSubmitting
                          ? null
                          : (value) {
                        setState(() {
                          currentRating = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: 220,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: isSubmitting
                          ? null
                          : () async {
                        setState(() {
                          isSubmitting = true;
                        });

                        try {
                          final ratingService =
                          TmdbRatingService();

                          await ratingService.rateMovie(
                            movieId: movieId,
                            rating: currentRating,
                          );

                          if (!context.mounted) {
                            return;
                          }

                          Navigator.pop(sheetContext);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            SnackBar(
                              content: Text(
                                "Rating ${currentRating.toStringAsFixed(1)} submitted successfully!",
                              ),
                              duration:
                              const Duration(
                                seconds: 2,
                              ),
                            ),
                          );
                        } catch (e) {
                          if (!context.mounted) {
                            return;
                          }

                          setState(() {
                            isSubmitting = false;
                          });

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Failed to submit rating.",
                              ),
                              duration:
                              Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color(0xff0296E5),
                        disabledBackgroundColor:
                        const Color(0xff0296E5)
                            .withOpacity(0.5),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),
                      child: isSubmitting
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child:
                        CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        "OK",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}