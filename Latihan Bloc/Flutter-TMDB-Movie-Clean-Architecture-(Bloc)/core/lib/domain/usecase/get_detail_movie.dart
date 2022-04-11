


import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/movie_detail.dart';
import '../repositories/movie_respository.dart';

class GetMovieDetail{
  final MovieRepository repository;
  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id){
    return repository.getDetailMovie(id);
  }
}