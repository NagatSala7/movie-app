import 'package:flutter/material.dart';

class EmptyWatchlistWidget extends StatelessWidget {
  const EmptyWatchlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/no_movie.png",
            width: 76,
            height: 76,
            fit: BoxFit.contain,
            errorBuilder: (
                context,
                error,
                stackTrace,
                ) {
              return const Icon(
                Icons.inbox_outlined,
                size: 76,
                color: Color(0xff0296E5),
              );
            },
          ),

          const SizedBox(height: 16),

          const Text(
            "There Is No Movie Yet!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Find your movie by Type title,\ncategories, years, etc",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff92929D),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}