import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:movie_nti_aug/models/movie_model.dart';
import 'package:movie_nti_aug/models/upcoming_movies_model.dart';

part 'upcoming_state.dart';

class UpcomingCubit extends Cubit<UpcomingState> {
  UpcomingCubit() : super(UpcomingInitial());

  void getUpcomingMovies() async {
    emit(GetUpcomingLoading());

    try {
      var dio = Dio();
      var res = await dio.get(
        "https://api.themoviedb.org/3/movie/upcoming?language=en&page=1",
        options: Options(
          headers: {
            "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYmYwNzRjYzk3MzE0YmRiMWZmM2VlMmQ3NWUwNWY0ZiIsIm5iZiI6MTc2MTM5NzAxOS4xMDgsInN1YiI6IjY4ZmNjOTFiYzQzZDA1OTllMjkzODUwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lzdT9GXoMtzophhJo7yb5wZ0MviXwdxUh7Lo1kVT1N4",
            "accept": "application/json",
          },
        ),
      );

      var movies = UpcomingMovieResponse.fromJson(res.data);


      emit(GetUpcomingSuccess(movies: movies.results));
    } catch (e) {
      emit(GetUpcomingFailure(message: e.toString()));
    }
  }
}