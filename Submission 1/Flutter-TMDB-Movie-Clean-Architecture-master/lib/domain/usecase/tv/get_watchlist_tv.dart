

import 'package:app_clean_architecture_flutter/domain/entities/tv/tv.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';

class GetWatchlistTv{
  final TvRepository _repository;
  GetWatchlistTv(this._repository);

  Future<Either<Failure, List<Tv>>> execute(){
    return _repository.getWatchlistTv();
  }
}