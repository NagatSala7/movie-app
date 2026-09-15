import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:movie_nti_aug/models/cast_model.dart';
import 'package:movie_nti_aug/models/movie_details_model.dart';
import 'package:movie_nti_aug/models/review_model.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieDetailsInitial());

  void getMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());

    try {
      var dio = Dio();
      const headers = {
        "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYmYwNzRjYzk3MzE0YmRiMWZmM2VlMmQ3NWUwNWY0ZiIsIm5iZiI6MTc2MTM5NzAxOS4xMDgsInN1YiI6IjY4ZmNjOTFiYzQzZDA1OTllMjkzODUwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lzdT9GXoMtzophhJo7yb5wZ0MviXwdxUh7Lo1kVT1N4",
        "accept": "application/json",
      };

      final detailsRes = await dio.get(
        "https://api.themoviedb.org/3/movie/$movieId",
        queryParameters: {"language": "en-US"},
        options: Options(headers: headers),
      );

      final creditsRes = await dio.get(
        "https://api.themoviedb.org/3/movie/$movieId/credits",
        queryParameters: {"language": "en-US"},
        options: Options(headers: headers),
      );

      final reviewsRes = await dio.get(
        "https://api.themoviedb.org/3/movie/$movieId/reviews",
        queryParameters: {"language": "en-US"},
        options: Options(headers: headers),
      );

      final movie = MovieDetailsModel.fromJson(detailsRes.data);

      final castList = (creditsRes.data['cast'] as List<dynamic>? ?? [])
          .map((item) => CastModel.fromJson(item))
          .toList();

      final reviewsList = (reviewsRes.data['results'] as List<dynamic>? ?? [])
          .map((item) => ReviewModel.fromJson(item))
          .toList();

      emit(MovieDetailsSuccess(
        movie: movie,
        cast: castList,
        reviews: reviewsList,
      ));
    } catch (e) {
      emit(MovieDetailsFailure(message: e.toString()));
    }
  }
}