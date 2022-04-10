


import 'package:app_clean_architecture_flutter/data/model/movie_model.dart';
import 'package:app_clean_architecture_flutter/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );


  test('should be a subclass of movie entity', () async {
    final result = tMovieModel.toEntity();
    expect(result, tMovie);
  });
}