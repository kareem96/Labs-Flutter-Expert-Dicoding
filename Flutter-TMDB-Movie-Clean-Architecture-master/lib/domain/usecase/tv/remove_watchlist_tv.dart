

import 'package:app_clean_architecture_flutter/common/failure.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv_detail.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveWatchlistTv{
  final TvRepository repository;
  RemoveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tvDetail){
    return repository.removeWatchlistTv(tvDetail);
  }
}