import 'package:flutter/material.dart';

class MovieInfoRow extends StatelessWidget {
  final String year;
  final String runtime;
  final String genre;

  const MovieInfoRow({
    super.key,
    required this.year,
    required this.runtime,
    required this.genre,
  });

  Widget _infoItem({
    required IconData icon,
    required String text,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: const Color(0xff92929D),
          size: 14,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xff92929D),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _infoItem(
            icon: Icons.calendar_today_outlined,
            text: year,
          ),

          const SizedBox(width: 12),

          const Text(
            "|",
            style: TextStyle(
              color: Color(0xff696C75),
            ),
          ),

          const SizedBox(width: 12),

          _infoItem(
            icon: Icons.access_time,
            text: "$runtime Minutes",
          ),

          const SizedBox(width: 12),

          const Text(
            "|",
            style: TextStyle(
              color: Color(0xff696C75),
            ),
          ),

          const SizedBox(width: 12),

          _infoItem(
            icon: Icons.confirmation_number_outlined,
            text: genre,
          ),
        ],
      ),
    );
  }
}