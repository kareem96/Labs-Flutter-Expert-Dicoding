


import 'package:app_clean_architecture_flutter/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv/tv.dart';

class GetTvOnTheAir{
  final TvRepository repository;

  GetTvOnTheAir(this.repository);
  Future<Either<Failure, List<Tv>>> execute(){
    return repository.getTvOnTheAir();
  }

}