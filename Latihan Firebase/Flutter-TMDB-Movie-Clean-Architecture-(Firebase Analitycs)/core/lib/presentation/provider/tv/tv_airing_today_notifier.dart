import 'package:core/utils/state_enum.dart';
import 'package:flutter/cupertino.dart';
import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecase/tv/get_tv_airing_today.dart';

class TvAiringTodayNotifier extends ChangeNotifier {
  final GetTvAiringToday getTvAiringToday;

  TvAiringTodayNotifier({required this.getTvAiringToday});

  String _message = '';

  String get message => _message;

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Tv> _airingTodayTv = [];

  List<Tv> get airingTodayTv => _airingTodayTv;

  Future<void> fetchTvAiringToday() async {
    final result = await getTvAiringToday.execute();

    result.fold(
            (failure) {
              _state = RequestState.Error;
              _message = failure.message;
              notifyListeners();
            },
            (dataTv) {
              _state = RequestState.Loaded;
              _airingTodayTv = dataTv;
              notifyListeners();
            });
  }
}
