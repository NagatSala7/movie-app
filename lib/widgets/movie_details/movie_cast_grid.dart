import 'package:flutter/material.dart';
import 'package:movie_nti_aug/models/cast_model.dart';

class MovieCastGrid extends StatelessWidget {
  final List<CastModel> cast;

  const MovieCastGrid({
    super.key,
    required this.cast,
  });

  @override
  Widget build(BuildContext context) {
    if (cast.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Text(
          "No cast info available.",
          style: TextStyle(
            color: Color(0xff92929D),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: cast.length,
      itemBuilder: (context, index) {
        final actor = cast[index];

        return Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xff3A3F47),
              backgroundImage: actor.profilePath != null
                  ? NetworkImage(
                "https://image.tmdb.org/t/p/w185${actor.profilePath}",
              )
                  : null,
              child: actor.profilePath == null
                  ? const Icon(
                Icons.person,
                size: 36,
                color: Colors.white54,
              )
                  : null,
            ),

            const SizedBox(height: 8),

            Text(
              actor.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}