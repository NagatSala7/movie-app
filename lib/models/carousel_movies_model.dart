import 'package:movie_nti_aug/models/movie_model.dart';

class CarouselMoviesResponse {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  CarouselMoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory CarouselMoviesResponse.fromJson(Map<String, dynamic> json) {
    return CarouselMoviesResponse(
      page: json['page'] ?? 0,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => MovieModel.fromJson(e))
          .toList() ??
          [],
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((e) => e.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}