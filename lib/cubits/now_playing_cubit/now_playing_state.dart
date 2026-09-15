part of 'now_playing_cubit.dart';

@immutable
sealed class NowPlayingState {}

final class NowPlayingInitial extends NowPlayingState {}
final class NowPlayingLoading extends NowPlayingState {}
final class NowPlayingSuccess extends NowPlayingState {
  final List<MovieModel> moviews;

  NowPlayingSuccess({required this.moviews});
}
final class NowPlayingFailure extends NowPlayingState {
  final String messgae;

  NowPlayingFailure({required this.messgae});
}