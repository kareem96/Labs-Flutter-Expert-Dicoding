

import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv/tv.dart';
import '../../repositories/tv_repository.dart';

class GetTvTopRated{
  final TvRepository repository;

  GetTvTopRated(this.repository);
  Future<Either<Failure, List<Tv>>> execute(){
    return repository.getTvTopRated();
  }
}