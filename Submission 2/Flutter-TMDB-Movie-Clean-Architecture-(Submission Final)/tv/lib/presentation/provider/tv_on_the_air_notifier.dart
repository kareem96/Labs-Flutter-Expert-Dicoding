


import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/cupertino.dart';
import '../../usecase/get_tv_on_the_air.dart';

class TvOnTheAirNotifier extends ChangeNotifier{
  final GetTvOnTheAir getTvOnTheAir;

  TvOnTheAirNotifier({required this.getTvOnTheAir});

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  Future<void> fetchTvOnTheAir()async{
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvOnTheAir.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (tvData) {
      _tv = tvData;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }

}