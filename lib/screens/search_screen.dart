import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_nti_aug/cubits/search_cubit/search_cubit.dart';
import 'package:movie_nti_aug/widgets/search/search_bar.dart';
import 'package:movie_nti_aug/widgets/search/movie_search_item.dart';
import 'package:movie_nti_aug/widgets/search/no_results_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _searchMovies(BuildContext context) {
    final query = searchController.text.trim();

    if (query.isEmpty) {
      return;
    }

    context.read<SearchCubit>().searchMovies(query);
  }

  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: const Color(0xff242A32),
            body: SafeArea(
              top: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Search",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () => _goBack(context),
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),

                          const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    SearchBarWidget(
                      controller: searchController,
                      onSearch: () => _searchMovies(context),
                    ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: BlocBuilder<SearchCubit, SearchState>(
                        builder: (context, state) {
                          if (state is SearchLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff0296E5),
                              ),
                            );
                          }

                          if (state is SearchSuccess) {
                            if (state.movies.isEmpty) {
                              return const NoResultsWidget();
                            }

                            return ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.movies.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 18);
                              },
                              itemBuilder: (context, index) {
                                return MovieSearchItem(
                                  movie: state.movies[index],
                                );
                              },
                            );
                          }

                          if (state is SearchFailure) {
                            return Center(
                              child: Text(
                                state.message,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            );
                          }

                          return const SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}