


import 'package:app_clean_architecture_flutter/domain/entities/movie.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/movie_respository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetPopularMovies{
  final MovieRepository repository;
  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(){
    return repository.getPopularMovies();
  }
}