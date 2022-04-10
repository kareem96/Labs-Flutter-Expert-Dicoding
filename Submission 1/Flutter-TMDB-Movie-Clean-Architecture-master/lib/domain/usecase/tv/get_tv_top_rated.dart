

import 'package:app_clean_architecture_flutter/common/failure.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv/tv.dart';

class GetTvTopRated{
  final TvRepository repository;

  GetTvTopRated(this.repository);
  Future<Either<Failure, List<Tv>>> execute(){
    return repository.getTvTopRated();
  }
}