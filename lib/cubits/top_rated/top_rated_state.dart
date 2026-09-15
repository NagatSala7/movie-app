part of 'top_rated_cubit.dart';

@immutable
sealed class TopRatedState {}

final class TopRatedInitial extends TopRatedState {}

final class GetTopRatedLoading extends TopRatedState {}
final class GetTopRatedSuccess extends TopRatedState {
  final List<MovieModel> movies;

  GetTopRatedSuccess({required this.movies});
}
final class GetTopRatedFailure extends TopRatedState {
  final String message;

  GetTopRatedFailure({required this.message});
}