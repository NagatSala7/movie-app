import 'package:flutter/material.dart';

class NoResultsWidget extends StatelessWidget {
  const NoResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/no-results.png",
            width: 120,
            height: 120,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.search_off,
                size: 80,
                color: Color(0xff67686D),
              );
            },
          ),

          const SizedBox(height: 20),

          const Text(
            "We Are Sorry, We Can Not\nFind The Movie :(",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Find your movie by Type,\ncategories, years, etc",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff92929D),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}