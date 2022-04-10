

import 'package:app_clean_architecture_flutter/domain/entities/tv/tv.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetWatchlistTv{
  final TvRepository _repository;
  GetWatchlistTv(this._repository);

  Future<Either<Failure, List<Tv>>> execute(){
    return _repository.getWatchlistTv();
  }
}