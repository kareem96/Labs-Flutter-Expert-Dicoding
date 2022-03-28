


import 'dart:io';

import 'package:app_clean_architecture_flutter/common/exception.dart';
import 'package:app_clean_architecture_flutter/common/failure.dart';
import 'package:app_clean_architecture_flutter/common/network_info.dart';
import 'package:app_clean_architecture_flutter/data/datasources/local_data_source.dart';
import 'package:app_clean_architecture_flutter/data/datasources/remote_data_source.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv_detail.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv_on_the_air.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class TvRepositoryImpl implements TvRepository{
  final MovieRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final MovieLocalDataSource localDataSource;
  TvRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo});



  @override
  Future<Either<Failure, List<Tv>>> getTvAiringToday() async{
    // TODO: implement getTvAiringToday
    try{
      final result = await remoteDataSource.getTvAiringToday();
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvOnTheAir() async{
    // TODO: implement getTvOnTheAir
    try{
      final result = await remoteDataSource.getTvOnTheAir();
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getDetailMovie(int id) async{
    // TODO: implement getDetailMovie
    try{
      final result = await remoteDataSource.getDetailTv(id);
      return Right(result.toEntity());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed connect to network'));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getDetailTv(int id) async {
    // TODO: implement getDetailTv
    try{
      final result = await remoteDataSource.getDetailTv(id);
      return Right(result.toEntity());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed connect to network'));
    }

  }

}