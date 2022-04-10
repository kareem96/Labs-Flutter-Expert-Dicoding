


import 'package:app_clean_architecture_flutter/domain/entities/movie_detail.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/movie_respository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetMovieDetail{
  final MovieRepository repository;
  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id){
    return repository.getDetailMovie(id);
  }
}