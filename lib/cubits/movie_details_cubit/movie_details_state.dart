part of 'movie_details_cubit.dart';

@immutable
sealed class MovieDetailsState {}

final class MovieDetailsInitial extends MovieDetailsState {}

final class MovieDetailsLoading extends MovieDetailsState {}

final class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetailsModel movie;
  final List<CastModel> cast;
  final List<ReviewModel> reviews;

  MovieDetailsSuccess({
    required this.movie,
    required this.cast,
    required this.reviews,
  });
}

final class MovieDetailsFailure extends MovieDetailsState {
  final String message;

  MovieDetailsFailure({
    required this.message,
  });
}