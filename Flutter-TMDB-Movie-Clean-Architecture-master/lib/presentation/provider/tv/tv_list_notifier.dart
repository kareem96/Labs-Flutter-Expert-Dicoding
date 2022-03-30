

import 'package:app_clean_architecture_flutter/common/state_enum.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/tv/get_tv_airing_today.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/tv/get_tv_on_the_air.dart';
import 'package:flutter/cupertino.dart';

class TvListNotifier extends ChangeNotifier{

  final GetTvAiringToday getTvAiringToday;
  final GetTvOnTheAir getTvOnTheAir;

  TvListNotifier({required this.getTvOnTheAir, required this.getTvAiringToday});


  ///
  String _message = '';
  String get message => _message;

  ///tv airing today
  var _airingTodayTv = <Tv>[];
  List<Tv> get airingTodayTv => _airingTodayTv;

  RequestState _airingTodayState = RequestState.Empty;
  RequestState get airingTodayState => _airingTodayState;

  ///tv on the air
  var _onTheAirTv = <Tv>[];
  List<Tv> get onTheAirTv => _onTheAirTv;

  RequestState _onTheAirTvState = RequestState.Empty;
  RequestState get onTheAirTvState => _onTheAirTvState;

  Future<void> fetchAiringTodayTv() async{
    _airingTodayState = RequestState.Loading;
    notifyListeners();

    final result = await getTvAiringToday.execute();
    result.fold((failure) {
      _airingTodayState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (dataTv) {
        _airingTodayState = RequestState.Loaded;
        _airingTodayTv = dataTv;
        notifyListeners();
    });
  }


  Future<void> fetchOnTheAirTv() async{
    _airingTodayState = RequestState.Loading;
    notifyListeners();

    final result = await getTvOnTheAir.execute();
    result.fold((failure) {
      _onTheAirTvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (dataTv) {
      _onTheAirTvState = RequestState.Loaded;
      _onTheAirTv = dataTv;
      notifyListeners();
    });
  }
}