


import 'package:app_clean_architecture_flutter/common/failure.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv_on_the_air.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv/tv.dart';

class GetTvOnTheAir{
  final TvRepository repository;

  GetTvOnTheAir(this.repository);
  Future<Either<Failure, List<Tv>>> execute(){
    return repository.getTvOnTheAir();
  }

}