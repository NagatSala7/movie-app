import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:movie_nti_aug/models/movie_details_model.dart';
import 'package:movie_nti_aug/widgets/watchlist/watchlist_item.dart';
import 'package:movie_nti_aug/widgets/watchlist/empty_watchlist_widget.dart';

class WatchlistScreen extends StatefulWidget {
  final bool showBackButton;
  final VoidCallback? onBackToHome;

  const WatchlistScreen({
    super.key,
    this.showBackButton = true,
    this.onBackToHome,
  });

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  final Box<MovieDetailsModel> watchlistBox =
  Hive.box<MovieDetailsModel>('watchlistBox');

  void _handleBack() {
    if (widget.onBackToHome != null) {
      widget.onBackToHome!();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff242A32),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 1),

              SizedBox(
                height: 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (widget.showBackButton)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: _handleBack,
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),

                    const Text(
                      "Watch list",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: watchlistBox.listenable(),
                  builder: (
                      context,
                      Box<MovieDetailsModel> box,
                      _,
                      ) {
                    final movies = box.values.toList();

                    if (movies.isEmpty) {
                      return const EmptyWatchlistWidget();
                    }

                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: movies.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 18);
                      },
                      itemBuilder: (context, index) {
                        return WatchlistItem(
                          movie: movies[index],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}