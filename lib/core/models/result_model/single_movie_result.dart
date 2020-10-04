import 'package:mov_id/core/models/movie.dart';
import 'package:mov_id/core/models/movie_detail.dart';

class SingleMovieResult {
  final MovieDetail movieDetail;
  final String error;

  SingleMovieResult({this.movieDetail, this.error});
}
