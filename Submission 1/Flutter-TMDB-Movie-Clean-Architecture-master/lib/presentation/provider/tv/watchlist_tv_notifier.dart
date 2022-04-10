

import 'package:app_clean_architecture_flutter/common/state_enum.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/tv/get_watchlist_tv.dart';
import 'package:flutter/cupertino.dart';

class WatchlistTvNotifier extends ChangeNotifier{
  var _watchlistTv = <Tv>[];
  List<Tv> get watchlistTv => _watchlistTv;

  var _watchlistStateTv = RequestState.Empty;
  RequestState get watchlistStateTv => _watchlistStateTv;

  String _message = '';
  String get message => _message;

  WatchlistTvNotifier({required this.getWatchlistTv});
  final GetWatchlistTv getWatchlistTv;

  Future<void> fetchWatchlistTv()async{
    _watchlistStateTv = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTv.execute();
    result.fold((failure) {
      _watchlistStateTv = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (success) {
      _watchlistStateTv = RequestState.Loaded;
      _watchlistTv = success;
      notifyListeners();
    });
  }
}