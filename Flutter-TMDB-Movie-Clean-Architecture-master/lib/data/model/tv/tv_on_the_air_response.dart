

import 'package:app_clean_architecture_flutter/data/model/tv/tv_model.dart';
import 'package:app_clean_architecture_flutter/data/model/tv/tv_on_the_air_model.dart';
import 'package:equatable/equatable.dart';

class TvOnTheAirResponse extends Equatable{
  final List<TvOnTheAirModel> tvList;

  const TvOnTheAirResponse({required this.tvList});

  factory TvOnTheAirResponse.fromJson(Map<String, dynamic> json) => TvOnTheAirResponse(
    tvList: List<TvOnTheAirModel>.from((json['results'] as List)
        .map((e) => TvOnTheAirModel.fromJson(e))
        .where((element) => element.backdropPath != null)
    ),
  );

  Map<String, dynamic> toJson() => {
    'results' : List<dynamic>.from(tvList.map((e) => e.toJson())),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    tvList,
  ];
}