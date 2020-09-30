import 'package:dio/dio.dart';
import 'package:mov_id/core/base/constant_variable.dart';
import 'package:mov_id/core/models/movie.dart';
import 'package:mov_id/core/models/result_model/list_movie_result.dart';

class MovieServices {
  static Dio _dio = Dio();
  static Future<ListMovieResult> getNowPlaying() async {
    try {
      var _params = {
        "api_key": ConstantVariable.apiKey,
        "language": "en-US",
        "page": '1',
      };
      var _url = ConstantVariable.baseUrl.replaceAll('%type%', 'now_playing');
      var _result = await _dio.get(_url, queryParameters: _params);

      var _movies = (_result.data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();

      print(_movies.length);

      return ListMovieResult(movies: _movies);
    } catch (e) {
      print(e);
      return ListMovieResult(error: e.toString());
    }
  }
}
