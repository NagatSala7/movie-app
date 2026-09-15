import 'package:flutter/material.dart';
import 'package:movie_nti_aug/screens/search_screen.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchScreen(),
          ),
        );
      },
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: const TextStyle(
          color: Color(0xff67686D),
        ),
        suffixIcon: const Icon(
          Icons.search,
          color: Color(0xff67686D),
        ),
        fillColor: const Color(0xff3A3F47),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
      cursorColor: const Color(0xff67686D),
    );
  }
}