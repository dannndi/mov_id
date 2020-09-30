import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final double voteAverage;
  final bool adult;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;

  Movie({
    this.id,
    this.title,
    this.voteAverage,
    this.adult,
    this.backdropPath,
    this.posterPath,
    this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        voteAverage,
        adult,
        backdropPath,
        posterPath,
        releaseDate,
      ];
}
