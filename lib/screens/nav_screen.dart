import 'package:flutter/material.dart';
import 'package:movie_nti_aug/screens/home_screen.dart';
import 'package:movie_nti_aug/screens/search_screen.dart';
import 'package:movie_nti_aug/screens/watchlist_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int index = 0;

  late List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = [
      const HomeScreen(),

      WatchlistScreen(
        showBackButton: true,
        onBackToHome: () {
          setState(() {
            index = 0;
          });
        },
      ),
    ];
  }

  void _openSearchScreen() {
    setState(() {
      index = 0;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff242A32),
      ),

      backgroundColor: const Color(0xff242A32),

      body: screens[index],

      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if (value == 1) {
            _openSearchScreen();
          } else {
            setState(() {
              if (value == 0) {
                index = 0;
              } else if (value == 2) {
                index = 1;
              }
            });
          }
        },

        currentIndex: index == 1 ? 2 : index,

        backgroundColor: const Color(0xff242A32),

        selectedItemColor: const Color(0xff0296E5),

        unselectedItemColor: const Color(0xff67686D),

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: "",
          ),
        ],
      ),
    );
  }
}