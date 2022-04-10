

import 'package:app_clean_architecture_flutter/domain/entities/tv/tv.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetRecommendationsTv{
  final TvRepository repository;

  GetRecommendationsTv(this.repository);
  Future<Either<Failure, List<Tv>>> execute(id){
    return repository.getRecommendationsTv(id);
  }

}