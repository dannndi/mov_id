import 'package:mov_id/core/models/movie.dart';

class ListMovieResult {
  final List<Movie> movies;
  final String error;

  ListMovieResult({this.movies, this.error});
}
