


import 'package:app_clean_architecture_flutter/common/state_enum.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/tv/get_tv_popular.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/tv/tv.dart';

class TvPopularNotifier extends ChangeNotifier{
  final GetTvPopular getTvPopular;

  TvPopularNotifier(this.getTvPopular);

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _popularTv =[];
  List<Tv> get popularTv => _popularTv;

  Future<void> fetchTvPopular() async{
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvPopular.execute();
    result.fold((failure) {
      _state = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (dataTv) {
      _state = RequestState.Loaded;
      _popularTv = dataTv;
      notifyListeners();
    });
  }


}