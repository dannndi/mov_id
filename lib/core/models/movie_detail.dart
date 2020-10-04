import 'package:equatable/equatable.dart';
import 'package:mov_id/core/models/movie.dart';

class MovieDetail extends Equatable {
  final int id;
  final String title;
  final String overView;
  final double voteAverage;
  final bool adult;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final List<String> genres;
  final String tagLine;
  final String language;
  final int runTime;

  MovieDetail({
    this.id,
    this.title,
    this.overView,
    this.voteAverage,
    this.adult,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    this.genres,
    this.tagLine,
    this.language,
    this.runTime,
  });

  factory MovieDetail.formJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'],
      title: json['title'],
      overView: json['overview'],
      voteAverage: json['vote_average'],
      adult: json['adult'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      releaseDate: json['release_date'],
      genres: (json['genres'] as List<dynamic>)
          .map((genre) => genre['name'].toString())
          .toList(),
      tagLine: json['tagline'],
      language: json['original_language'],
      runTime: json['runtime'],
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        overView,
        voteAverage,
        adult,
        posterPath,
        backdropPath,
        releaseDate,
        genres,
        tagLine,
        language,
        runTime,
      ];
}
