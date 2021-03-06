


import 'package:app_clean_architecture_flutter/data/model/movie_model.dart';
import 'package:equatable/equatable.dart';

class MovieResponse extends Equatable{
  final List<MovieModel> movieList;

  const MovieResponse({required this.movieList});

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
    movieList: List<MovieModel>.from((json['results'] as List)
        .map((e) => MovieModel.fromJson(e))
        .where((element) => element.posterPath != null)),
  );

  Map<String, dynamic> toJson() => {
    'results':List<dynamic>.from(movieList.map((e) => e.toJson())),
  };

  @override
  List<Object?> get props => [movieList];

}