


import 'package:app_clean_architecture_flutter/common/failure.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class GetTvAiringToday{
  final TvRepository repository;

  GetTvAiringToday(this.repository);
  Future<Either<Failure, List<Tv>>> execute(){
    return repository.getTvAiringToday();
  }

}