

import 'package:app_clean_architecture_flutter/common/failure.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv_detail.dart';
import 'package:dartz/dartz.dart';

abstract class TvRepository{
  Future<Either<Failure, TvDetail>> getDetailTv(int id);


  Future<Either<Failure, List<Tv>>> getTvAiringToday();
  Future<Either<Failure, List<Tv>>> getTvOnTheAir();
}