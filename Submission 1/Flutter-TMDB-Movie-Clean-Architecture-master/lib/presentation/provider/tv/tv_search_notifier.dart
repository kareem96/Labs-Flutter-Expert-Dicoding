

import 'package:app_clean_architecture_flutter/common/state_enum.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/tv/search_tv.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/tv/tv.dart';

class TvSearchNotifier extends ChangeNotifier{
  final SearchTv searchTv;
  TvSearchNotifier({required this.searchTv});

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _searchResultTv = [];
  List<Tv> get searchResultTv => _searchResultTv;

  Future<void> fetchTvSearch(String query) async{
    _state = RequestState.Loading;
    notifyListeners();
    final result = await searchTv.execute(query);
    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (success){
      _searchResultTv = success;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }

}