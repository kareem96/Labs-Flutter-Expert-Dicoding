


import 'package:app_clean_architecture_flutter/common/failure.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv_detail.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class GetTvDetail{
  final TvRepository repository;


  GetTvDetail(
      this.repository
      );

  Future<Either<Failure, TvDetail>> execute(int id){
    return repository.getDetailTv(id);
  }
}