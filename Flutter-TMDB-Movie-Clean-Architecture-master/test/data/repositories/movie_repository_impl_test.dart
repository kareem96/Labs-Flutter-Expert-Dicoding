import 'dart:async';

import 'package:app_clean_architecture_flutter/common/exception.dart';
import 'package:app_clean_architecture_flutter/data/model/movie_model.dart';
import 'package:app_clean_architecture_flutter/data/model/movie_table.dart';
import 'package:app_clean_architecture_flutter/data/repositories/movie_repository_impl.dart';
import 'package:app_clean_architecture_flutter/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MovieRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo,
    );
  });

  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final testMovieCacheMap = {
    'id': 557,
    'overview':
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    'title': 'Spider-Man',
  };

  final testMovieCache = MovieTable(
    id: 557,
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    title: 'Spider-Man',
  );



  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  group('Now Playing Movies', () {
    setUp((){
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    test('should check if the device is online', () async {
      ///arrange
      when(mockRemoteDataSource.getNowPlaying()).thenAnswer((_) async => []);

      ///act
      await repository.getNowPlaying();
      ///assert
      verify(mockNetworkInfo.isConnected);
    });

  });

  group('when device is online', (){
    setUp((){
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    test('should return remote data when the call to remote data source is successful', () async{
      ///arrange
      when(mockRemoteDataSource.getNowPlaying()).thenAnswer((_) async => tMovieModelList);
      ///act
      final result = await repository.getNowPlaying();
      ///assert
      verify(mockRemoteDataSource.getNowPlaying());

      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });


    test('should cache data locally when call to remote data source is successful', () async{
      ///arrange
      when(mockRemoteDataSource.getNowPlaying()).thenAnswer((_) async => tMovieModelList);
      ///act
      await repository.getNowPlaying();
      ///assert
      verify(mockRemoteDataSource.getNowPlaying());
      verify(mockLocalDataSource.cacheNowPlayingMovies([testMovieCache]));
    });

    test('should return cached data when device is offline', () async{
      when(mockLocalDataSource.getCacheNowPlaying()).thenAnswer((_) async => [testMovieCache]);

      final result = await repository.getNowPlaying();

      verify(mockLocalDataSource.getCacheNowPlaying());
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testMovieCache]);
    });

    test('should return CacheFailure when app has no cache', () async {
      when(mockLocalDataSource.getCacheNowPlaying()).thenThrow(CacheException('No Cache'));

      final result = await repository.getNowPlaying();

      verify(mockLocalDataSource.getCacheNowPlaying());
      expect(result, Left(CacheException('No Cache')));
    });

  });

  group('cache now playing movies', (){
    test('should call database helper to save data', () async{
      
    });
  });


}