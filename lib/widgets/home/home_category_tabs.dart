import 'package:flutter/material.dart';

class HomeCategoryTabs extends StatelessWidget {
  const HomeCategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      indicatorColor: Color(0xff3A3F47),
      dividerHeight: 0,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: [
        Tab(text: "Now playing"),
        Tab(text: "upcoming"),
        Tab(text: "top rated"),
        Tab(text: "popular"),
      ],
    );
  }
}