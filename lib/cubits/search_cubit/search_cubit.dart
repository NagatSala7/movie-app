import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:movie_nti_aug/models/movie_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  void searchMovies(String query) async {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      var dio = Dio();

      var res = await dio.get(
        "https://api.themoviedb.org/3/search/movie",
        queryParameters: {
          "query": query,
          "include_adult": false,
          "language": "en-US",
          "page": 1,
        },
        options: Options(
          headers: {
            "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYmYwNzRjYzk3MzE0YmRiMWZmM2VlMmQ3NWUwNWY0ZiIsIm5iZiI6MTc2MTM5NzAxOS4xMDgsInN1YiI6IjY4ZmNjOTFiYzQzZDA1OTllMjkzODUwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lzdT9GXoMtzophhJo7yb5wZ0MviXwdxUh7Lo1kVT1N4",
            "accept": "application/json",
          },
        ),
      );

      List results = res.data["results"];

      List<MovieModel> movies = results
          .map((movie) => MovieModel.fromJson(movie))
          .toList();

      emit(SearchSuccess(movies: movies));
    } catch (e) {
      emit(SearchFailure(message: e.toString()));
    }
  }
}