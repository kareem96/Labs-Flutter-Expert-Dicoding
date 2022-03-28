

import 'package:app_clean_architecture_flutter/common/state_enum.dart';
import 'package:app_clean_architecture_flutter/domain/entities/tv/tv_detail.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/usecase/tv/get_tv_detail.dart';

class TvDetailNotifier extends ChangeNotifier{
  final GetTvDetail getTvDetail;

  TvDetailNotifier({required this.getTvDetail});


  String _message = '';
  String get message => _message;

  RequestState _tvDetailState = RequestState.Empty;
  RequestState get tvDetailState => _tvDetailState;


  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;

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
}