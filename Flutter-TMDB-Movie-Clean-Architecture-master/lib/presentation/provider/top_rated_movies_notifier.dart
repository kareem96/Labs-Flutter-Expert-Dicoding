



import 'package:app_clean_architecture_flutter/common/state_enum.dart';
import 'package:app_clean_architecture_flutter/domain/entities/movie.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/get_top_rated_movies.dart';
import 'package:flutter/cupertino.dart';

class TopRatedMoviesNotifier extends ChangeNotifier{
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesNotifier({required this.getTopRatedMovies});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _movie = [];
  List<Movie> get movie => _movie;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedMovies() async{
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (moviesData) {
      _movie = moviesData;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}