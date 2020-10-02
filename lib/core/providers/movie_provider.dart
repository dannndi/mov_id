import 'package:flutter/cupertino.dart';
import 'package:mov_id/core/models/movie.dart';
import 'package:mov_id/core/services/movie_services.dart';

class MovieProvider extends ChangeNotifier {
  //* list now playing movie
  List<Movie> _nowPlayingMovies;
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  //* list now playing movie
  List<Movie> _comingSoonMovies;
  List<Movie> get comingSoonMovies => _comingSoonMovies;

  //* methode for getting now playing movies
  void getNowPlaying() async {
    var _result = await MovieServices.getNowPlaying();
    if (_result.error == null) {
      _nowPlayingMovies = _result.movies;
    }
    notifyListeners();
  }

  //methode for get coming soon movies
  void getComingSoon() async {
    var _result = await MovieServices.getComingSoon();
    if (_result.error == null) {
      _comingSoonMovies = _result.movies;
    }
    notifyListeners();
  }
}
