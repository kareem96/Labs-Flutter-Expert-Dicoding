

import 'package:core/domain/entities/tv/tv.dart';
import '../../../../../tv/lib/usecase/get_recommendations_tv.dart';
import '../../../../../tv/lib/usecase/get_tv_detail.dart';
import 'package:core/domain/usecase/tv/get_watchlist_status_tv.dart';
import 'package:core/domain/usecase/tv/remove_watchlist_tv.dart';
import 'package:core/domain/usecase/tv/save_watchlist_tv.dart';
import '../../../../../tv/lib/presentation/provider/tv_detail_notifier.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetRecommendationsTv,
  GetWatchlistStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])

void main(){
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetRecommendationsTv mockGetRecommendationsTv;
  late MockGetWatchlistStatusTv mockGetWatchlistStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late int listenerCallCount;
  setUp((){
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetRecommendationsTv = MockGetRecommendationsTv();
    mockGetWatchlistStatusTv = MockGetWatchlistStatusTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    provider = TvDetailNotifier(
        getTvDetail: mockGetTvDetail,
        getWatchlistStatusTv: mockGetWatchlistStatusTv,
        removeWatchlistTv: mockRemoveWatchlistTv,
        saveWatchlistTv: mockSaveWatchlistTv,
        getTvRecommendations: mockGetRecommendationsTv
    )..addListener(() { listenerCallCount +=1;
    });
  });

  final tId = 1;

  final testTv = Tv(
      backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
      genreIds: [18],
      id: 11250,
      name: "Pasión de gavilanes",
      originCountry: ["CO"],
      originalLanguage: "es",
      originalName: "Pasión de gavilanes",
      overview: "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
      popularity: 3645.173,
      posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
      voteAverage: 7.6,
      voteCount: 1765
  );

  final tv = <Tv>[testTv];
  void _arrangeUsecase(){
    when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => Right(testTvDetail));
    when(mockGetRecommendationsTv.execute(tId)).thenAnswer((_) async => Right(tv));
  }

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      ///arrange
      when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetRecommendationsTv.execute(tId)).thenAnswer((_) async => Right(tv));
      ///act
      await provider.fetchTvDetail(tId);
      ///assert
      expect(provider.tvDetailState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Get Movie Detail', () {
    test('should get data from the usecase', () async {
      ///arrange
      _arrangeUsecase();
      ///act
      await provider.fetchTvDetail(tId);
      ///assert
      verify(mockGetTvDetail.execute(tId));
      verify(mockGetRecommendationsTv.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      ///arrange
      _arrangeUsecase();
      ///act
      provider.fetchTvDetail(tId);
      ///assert
      expect(provider.tvDetailState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });


    test('should change recommendation movies when data is gotten successfully', () async {
      ///arrange
      _arrangeUsecase();
      ///act
      await provider.fetchTvDetail(tId);
      ///assert
      expect(provider.tvDetailState, RequestState.Loaded);
      expect(provider.tvRecommendation, tv);
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      ///arrange
      when(mockGetWatchlistStatusTv.execute(1)).thenAnswer((_) async => true);
      ///act
      await provider.loadWatchlistStatusTv(1);
      ///assert
      expect(provider.isAddedToWatchListTv, true);
    });

    test('should execute save watchlist when function called', () async {
      ///arrange
      when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatusTv.execute(testTvDetail.id)).thenAnswer((_) async => true);
      ///act
      await provider.addWatchlist(testTvDetail);
      //assert
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      ///arrange
      when(mockRemoveWatchlistTv.execute(testTvDetail)).thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatusTv.execute(testTvDetail.id)).thenAnswer((_) async => false);
      ///act
      await provider.removeFromWatchlistTv(testTvDetail);
      //assert
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      //arrange
      when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatusTv.execute(testTvDetail.id)).thenAnswer((_) async => true);
      //act
      await provider.addWatchlist(testTvDetail);
      ///assert
      verify(mockGetWatchlistStatusTv.execute(testTvDetail.id));
      expect(provider.isAddedToWatchListTv, true);
      expect(provider.watchlistMessageTv, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      ///arrange
      when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer((_) async => Left(DataBaseFailure('Failed')));
      when(mockGetWatchlistStatusTv.execute(testMovieDetail.id)).thenAnswer((_) async => false);
      ///act
      await provider.addWatchlist(testTvDetail);
      ///assert
      expect(provider.watchlistMessageTv, 'Failed');
      expect(listenerCallCount, 1);
    });

  });

  group('Get Movie Recommendations', () {
    test('should get data from the usecase', () async {
      ///arrange
      _arrangeUsecase();
      ///act
      await provider.fetchTvDetail(tId);
      ///assert
      verify(mockGetRecommendationsTv.execute(tId));
      expect(provider.tvRecommendation, tv);
    });

    test('should update recommendation state when data is gotten successfully', () async {
      ///arrange
      _arrangeUsecase();
      ///act
      await provider.fetchTvDetail(tId);
      ///assert
      expect(provider.tvRecommendationState, RequestState.Loaded);
      expect(provider.tvRecommendation, tv);
    });

    test('should update error message when request in successful', () async {
      ///arrange
      when(mockGetTvDetail.execute(tId)).thenAnswer((_) async => Right(testTvDetail));
      when(mockGetRecommendationsTv.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      ///act
      await provider.fetchTvDetail(tId);
      ///assert
      expect(provider.tvRecommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

}