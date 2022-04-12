




import 'package:core/domain/entities/tv/tv.dart';
import '../../../../../tv/lib/usecase/get_tv_popular.dart';
import '../../../../../tv/lib/presentation/provider/tv_popular_notifier.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_popular_notifier_test.mocks.dart';


@GenerateMocks([
  GetTvPopular
])
void main(){
  late MockGetTvPopular mockGetTvPopular;
  late TvPopularNotifier notifier;
  late int listenerCallCount;

  setUp((){
    listenerCallCount = 0;
    mockGetTvPopular = MockGetTvPopular();
    notifier = TvPopularNotifier(mockGetTvPopular)..addListener(() {
      listenerCallCount++;
    });
  });

  final testTv = Tv(
      backdropPath: "backdropPath",
      genreIds: [1,2,3],
      id: 1,
      name: "name",
      originCountry: ["CO"],
      originalLanguage: "es",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 1,
      voteCount: 1
  );
  final tvList = <Tv>[testTv];

  test('should change state to loading when usecase is called', () async {
    ///arrange
    when(mockGetTvPopular.execute()).thenAnswer((_) async => Right(tvList));
    ///act
    notifier.fetchTvPopular();
    ///assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    ///arrange
    when(mockGetTvPopular.execute()).thenAnswer((_) async => Right(tvList));
    ///act
    await notifier.fetchTvPopular();
    ///assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.popularTv, tvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    ///arrange
    when(mockGetTvPopular.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    ///act
    await notifier.fetchTvPopular();
    ///assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}