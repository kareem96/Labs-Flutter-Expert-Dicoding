

import 'package:app_clean_architecture_flutter/common/failure.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv_detail.dart';
import 'package:dartz/dartz.dart';

abstract class TvRepository{
  Future<Either<Failure, TvDetail>> getDetailTv(int id);
  Future<Either<Failure, List<Tv>>> getTvAiringToday();
  Future<Either<Failure, List<Tv>>> getTvOnTheAir();
  Future<Either<Failure, List<Tv>>> getTvTopRated();
  Future<Either<Failure, List<Tv>>> getTvPopular();

  Future<Either<Failure, List<Tv>>> searchTv(String query);

  ///
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tvDetail);
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tvDetail);
  Future<bool> isAddedToWatchlistTv(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTv();
}