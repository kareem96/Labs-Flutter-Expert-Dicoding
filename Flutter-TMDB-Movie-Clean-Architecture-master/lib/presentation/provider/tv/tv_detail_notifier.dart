
import 'package:app_clean_architecture_flutter/common/state_enum.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv_detail.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/usecase/tv/get_tv_detail.dart';
import '../../../domain/usecase/tv/get_watchlist_status_tv.dart';
import '../../../domain/usecase/tv/get_watchlist_tv.dart';
import '../../../domain/usecase/tv/remove_watchlist_tv.dart';
import '../../../domain/usecase/tv/save_watchlist_tv.dart';

class TvDetailNotifier extends ChangeNotifier{
  static const  watchlistAddSuccessMessage = 'Added to watchlist';
  static const  watchlistRemoveSuccessMessage = 'Remove from watchlist';

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


  Future<void> fetchTvDetail(int id) async{
    _tvDetailState = RequestState.Loading;
    notifyListeners();
    final detailTvResult = await getTvDetail.execute(id);
    detailTvResult.fold((failure) {
      _tvDetailState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (dataTvDetail) {
      _tvDetail = dataTvDetail;
      _tvDetailState = RequestState.Loaded;
      notifyListeners();
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