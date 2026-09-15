import 'package:movie_nti_aug/models/movie_model.dart';

class NowPlayingMovieResponse {
  final Dates dates;
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  NowPlayingMovieResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory NowPlayingMovieResponse.fromJson(Map<String, dynamic> json) {
    return NowPlayingMovieResponse(
      dates: Dates.fromJson(json['dates']),
      page: json['page'] ?? 0,
      results: (json['results'] as List<dynamic>? ?? [])
          .map((e) => MovieModel.fromJson(e))
          .toList(),
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }
}

class Dates {
  final String maximum;
  final String minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
      maximum: json['maximum'] ?? '',
      minimum: json['minimum'] ?? '',
    );
  }
}