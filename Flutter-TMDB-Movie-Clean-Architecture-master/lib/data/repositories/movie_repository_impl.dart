



import 'dart:io';

import 'package:app_clean_architecture_flutter/common/exception.dart';
import 'package:app_clean_architecture_flutter/common/failure.dart';
import 'package:app_clean_architecture_flutter/common/network_info.dart';
import 'package:app_clean_architecture_flutter/data/datasources/local_data_source.dart';
import 'package:app_clean_architecture_flutter/data/datasources/remote_data_source.dart';
import 'package:app_clean_architecture_flutter/data/model/movie_table.dart';
import 'package:app_clean_architecture_flutter/domain/entities/movie.dart';
import 'package:app_clean_architecture_flutter/domain/entities/movie_detail.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/movie_respository.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl implements MovieRepository{
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });



  @override
  Future<Either<Failure, List<Movie>>> getNowPlaying() async {
    // TODO: implement getNowPlaying
    // networkInfo.isConnected;
    if(await networkInfo.isConnected){
      try{
        final result = await remoteDataSource.getNowPlaying();
        localDataSource.cacheNowPlayingMovies(result.map((movie) => MovieTable.fromDTO(movie)).toList());
        return Right(result.map((model) => model.toEntity()).toList());
      }on ServerException{
        return Left(ServerFailure(''));
      }on SocketException{
        return Left(ConnectionFailure('Failed to connect network!'));
      }
    }else{
      try{
        final result = await localDataSource.getCacheNowPlaying();
        return Right(result.map((model) => model.toEntity()).toList());
      }on CacheException catch (e){
        return Left(CacheFailure(e.message));
      }
    }

  }

  @override
  Future<Either<Failure, MovieDetail>> getDetailMovie(int id) async{
    // TODO: implement getDetailMovie
    try{
      final result = await remoteDataSource.getDetailMovie(id);
      return Right(result.toEntity());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed connect to network!'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id) async{
    try{
      final result = await remoteDataSource.getMovieRecommendations(id);
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
     return Left(ConnectionFailure('Failed connect to network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async{
    try{
      final result = await remoteDataSource.getPopularMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failure to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async{
    try{
      final result = await remoteDataSource.searchMovies(query);
      return Right(result.map((model) => model.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failure to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getWatchlistMovies() async{
    final result = await localDataSource.getWatchlistMovies();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async{
    final result = await localDataSource.getMovieById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie) async{
    try{
      final result = await localDataSource.removeWatchlist(MovieTable.fromEntity(movie));
      return Right(result);
    }on DataBaseException catch (e){
      return Left(DataBaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie) async{
    try{
      final result = await localDataSource.insertWatchlist(MovieTable.fromEntity(movie));
      return Right(result);
    }on DataBaseException catch (e){
      return Left(DataBaseFailure(e.message));
    }catch(e){
      throw e;
    }
  }

}