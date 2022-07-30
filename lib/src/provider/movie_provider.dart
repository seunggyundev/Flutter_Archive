import 'package:archive/src/model/movie.dart';
import 'package:archive/src/repository/movie_repository.dart';
import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier{
  MovieRepository _movieRepository = MovieRepository();
  List<Movie> _movies = [];  // 가공이 필요하므로 프라이빗으로 선언
  List<Movie> get movies => _movies;
  loadMovies() async {
    List<Movie> listMovies = await _movieRepository.loadMovies();
    // listMovies 예외 처리 해주고
    // 추가적인 가공절차
    _movies = listMovies;
    notifyListeners();
  }
}