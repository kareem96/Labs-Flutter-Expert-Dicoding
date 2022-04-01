
import 'package:app_clean_architecture_flutter/common/state_enum.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv_detail.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/usecase/tv/get_recommendations_tv.dart';
import '../../../domain/usecase/tv/get_tv_detail.dart';
import '../../../domain/usecase/tv/get_watchlist_status_tv.dart';
import '../../../domain/usecase/tv/get_watchlist_tv.dart';
import '../../../domain/usecase/tv/remove_watchlist_tv.dart';
import '../../../domain/usecase/tv/save_watchlist_tv.dart';

class TvDetailNotifier extends ChangeNotifier{
  static const  watchlistAddSuccessMessage = 'Added to watchlist';
  static const  watchlistRemoveSuccessMessage = 'Remove from watchlist';


  final GetRecommendationsTv getTvRecommendations;
  final GetTvDetail getTvDetail;
  final GetWatchlistTv getWatchlistTv;
  final SaveWatchlistTv saveWatchlistTv;
  final GetWatchlistStatusTv getWatchlistStatusTv;
  final RemoveWatchlistTv removeWatchlistTv;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getWatchlistTv,
    required this.getWatchlistStatusTv,
    required this.removeWatchlistTv,
    required this.saveWatchlistTv,
    required this.getTvRecommendations,
  });

  String _message = '';
  String get message => _message;

  RequestState _tvDetailState = RequestState.Empty;
  RequestState get tvDetailState => _tvDetailState;

  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;

  ///
  bool _isAddedToWatchListTv = false;
  bool get isAddedToWatchListTv => _isAddedToWatchListTv;
  String _watchlistMessageTv = '';
  String get watchlistMessageTv => _watchlistMessageTv;

  ///
  List<Tv> _tvRecommendation = [];
  List<Tv> get tvRecommendation => _tvRecommendation;

  RequestState _tvRecommendationState = RequestState.Empty;
  RequestState get tvRecommendationState => _tvRecommendationState;


  Future<void> fetchTvDetail(int id) async{
    _tvDetailState = RequestState.Loading;
    notifyListeners();

    final detailTvResult = await getTvDetail.execute(id);
    final tvRecommendationResult = await getTvRecommendations.execute(id);

    detailTvResult.fold((failure) {
      _tvDetailState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (dataTvDetail) {
      _tvRecommendationState = RequestState.Loading;
      _tvDetail = dataTvDetail;
      notifyListeners();
      _tvDetailState = RequestState.Loaded;
      notifyListeners();
      tvRecommendationResult.fold((failure) {
        _tvRecommendationState = RequestState.Error;
        _message = failure.message;
      }, (success) {
        _tvRecommendationState = RequestState.Loaded;
        _tvRecommendation = success;
      });
    });
  }

  Future<void> addWatchlist(TvDetail tvDetail)async{
    final result = await saveWatchlistTv.execute(tvDetail);
    await result.fold((failure) {
      _watchlistMessageTv = failure.message;
    }, (success) {
      _watchlistMessageTv = success;
    });
    await loadWatchlistStatusTv(tvDetail.id);
  }

  Future<void> loadWatchlistStatusTv(int id) async{
    final result = await getWatchlistStatusTv.execute(id);
    _isAddedToWatchListTv = result;
    notifyListeners();
  }

  Future<void> removeFromWatchlistTv(TvDetail tvDetail)async{
    final result = await removeWatchlistTv.execute(tvDetail);
    await result.fold((failure) {
      _watchlistMessageTv = failure.message;
    }, (success) {
      _watchlistMessageTv = success;
    });
    await loadWatchlistStatusTv(tvDetail.id);
  }
}