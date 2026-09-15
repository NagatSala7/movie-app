part of 'upcoming_cubit.dart';

@immutable
sealed class UpcomingState {}

final class UpcomingInitial extends UpcomingState {}

final class GetUpcomingLoading extends UpcomingState {}
final class GetUpcomingSuccess extends UpcomingState {
  final List<MovieModel> movies;

  GetUpcomingSuccess({required this.movies});
}
final class GetUpcomingFailure extends UpcomingState {
  final String message;

  GetUpcomingFailure({required this.message});
}