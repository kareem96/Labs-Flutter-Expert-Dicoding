


import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv/tv.dart';
import '../../repositories/tv_repository.dart';

class GetTvAiringToday{
  final TvRepository repository;

  GetTvAiringToday(this.repository);
  Future<Either<Failure, List<Tv>>> execute(){
    return repository.getTvAiringToday();
  }

}