



import 'package:app_clean_architecture_flutter/data/model/genre_model.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/tv/tv_detail_model.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.seasons,
    required this.genres,
    required this.adult,
    required this.backdropPath,
    required this.firstAirDate,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.lastAirDate,
    required this.name,
    required this.nextEpisodeToAir,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  List<GenreModel> genres;
  List<Season> seasons;
  bool adult;
  String backdropPath;
  DateTime firstAirDate;
  String homepage;
  int id;
  bool inProduction;
  DateTime lastAirDate;
  String name;
  dynamic nextEpisodeToAir;
  int numberOfEpisodes;
  int numberOfSeasons;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  String status;
  String tagline;
  String type;
  double voteAverage;
  int voteCount;

  @override
  // TODO: implement props
  List<Object?> get props => [
    seasons,
    genres,
    adult,
    backdropPath,
    firstAirDate,
    homepage,
    id,
    inProduction,
    lastAirDate,
    name,
    nextEpisodeToAir,
    numberOfEpisodes,
    numberOfSeasons,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    status,
    tagline,
    type,
    voteAverage,
    voteCount,
  ];
}
