
import 'package:core/utils/state_enum.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecase/get_now_playing_movies.dart';
import '../../domain/usecase/get_popular_movies.dart';
import '../../domain/usecase/get_top_rated_movies.dart';

class MovieListNotifier extends ChangeNotifier {
  ///now playing
  var _nowPlayingMovies = <Movie>[];
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  ///popular
  var _popularMovies = <Movie>[];
  List<Movie> get popularMovies => _popularMovies;

  RequestState _popularMoviesState = RequestState.Empty;
  RequestState get popularMoviesState => _popularMoviesState;

  ///top rated
  var _topRatedMovies = <Movie>[];
  List<Movie> get topRatedMovies => _topRatedMovies;

  RequestState _topRatedMoviesState = RequestState.Empty;
  RequestState get topRatedMoviesState => _topRatedMoviesState;

  ///
  String _message = '';
  String get message => _message;

  MovieListNotifier({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  });

  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();
    result.fold(
          (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (moviesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularMovies() async{
    _popularMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();
    result.fold(
            (failure) {
              _popularMoviesState = RequestState.Error;
              _message = failure.message;
              notifyListeners();
            },
            (data) {
              _popularMoviesState = RequestState.Loaded;
              _popularMovies = data;
              notifyListeners();
            });
  }

  Future<void> fetchTopRatedMovies() async{
    _topRatedMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();
    result.fold((failure) {
      _topRatedMoviesState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _topRatedMoviesState = RequestState.Loaded;
      _topRatedMovies = data;
      notifyListeners();
    });
  }

}