import 'package:dio/dio.dart';

class TmdbRatingService {
  static const String accessToken =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYmYwNzRjYzk3MzE0YmRiMWZmM2VlMmQ3NWUwNWY0ZiIsIm5iZiI6MTc2MTM5NzAxOS4xMDgsInN1YiI6IjY4ZmNjOTFiYzQzZDA1OTllMjkzODUwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lzdT9GXoMtzophhJo7yb5wZ0MviXwdxUh7Lo1kVT1N4';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      headers: {
        'Authorization': 'Bearer $accessToken',
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  String? _guestSessionId;

  Future<String> _createGuestSession() async {
    if (_guestSessionId != null) {
      return _guestSessionId!;
    }

    try {
      final response = await _dio.get(
        '/authentication/guest_session/new',
      );

      _guestSessionId = response.data['guest_session_id'];

      return _guestSessionId!;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['status_message'] ??
            'Failed to create guest session',
      );
    }
  }

  Future<void> rateMovie({
    required int movieId,
    required double rating,
  }) async {
    try {
      final guestSessionId = await _createGuestSession();

      await _dio.post(
        '/movie/$movieId/rating',
        queryParameters: {
          'guest_session_id': guestSessionId,
        },
        data: {
          'value': rating,
        },
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['status_message'] ??
            'Failed to submit rating',
      );
    }
  }
}