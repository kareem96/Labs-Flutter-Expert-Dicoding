import 'package:app_clean_architecture_flutter/common/network_info.dart';
import 'package:app_clean_architecture_flutter/data/datasources/db/database_helper.dart';
import 'package:app_clean_architecture_flutter/data/datasources/local_data_source.dart';
import 'package:app_clean_architecture_flutter/data/datasources/remote_data_source.dart';
import 'package:app_clean_architecture_flutter/data/repositories/movie_repository_impl.dart';
import 'package:app_clean_architecture_flutter/data/repositories/tv_repository_impl.dart';
import 'package:app_clean_architecture_flutter/domain/repositories/movie_respository.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/get_detail_movie.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/get_now_playing_movies.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/get_popular_movies.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/get_recommended_movie.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/get_top_rated_movies.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/get_watchlist_movies.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/get_watchlist_status.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/remove_watchlist.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/save_watchlist.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/search_movies.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/tv/get_tv_airing_today.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/tv/get_tv_detail.dart';
import 'package:app_clean_architecture_flutter/domain/usecase/tv/get_tv_on_the_air.dart';
import 'package:app_clean_architecture_flutter/presentation/provider/movie_detail_notifier.dart';
import 'package:app_clean_architecture_flutter/presentation/provider/movie_list_notifier.dart';
import 'package:app_clean_architecture_flutter/presentation/provider/movie_search_notifier.dart';
import 'package:app_clean_architecture_flutter/presentation/provider/popular_movies_notifier.dart';
import 'package:app_clean_architecture_flutter/presentation/provider/top_rated_movies_notifier.dart';
import 'package:app_clean_architecture_flutter/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:app_clean_architecture_flutter/presentation/provider/tv/tv_list_notifier.dart';
import 'package:app_clean_architecture_flutter/presentation/provider/watchlist_movie_notifier.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'domain/repositories/tv_repository.dart';

final locator = GetIt.instance;

void init() {
  ///provider movies
  locator.registerFactory(() => MovieListNotifier(
        getNowPlayingMovies: locator(),
        getPopularMovies: locator(),
        getTopRatedMovies: locator(),
      ));

  ///provider tv
  locator.registerFactory(() => TvListNotifier(
      getTvAiringToday: locator(),
      getTvOnTheAir: locator()
  ));

  locator.registerFactory(() => TvDetailNotifier(
      getTvDetail: locator()
  ));

  locator.registerFactory(() => MovieDetailNotifier(
        getMovieDetail: locator(),
        getMovieRecommendations: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ));


  locator.registerFactory(() => MovieSearchNotifier(searchMovies: locator()));

  locator.registerFactory(() => PopularMoviesNotifier(locator()));

  locator.registerFactory(() => WatchlistMovieNotifier(getWatchlistMovies: locator()));

  locator.registerFactory(() => TopRatedMoviesNotifier(getTopRatedMovies: locator()));

  ///use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));

  ///use case tv
  locator.registerLazySingleton(() => GetTvAiringToday(locator()));
  locator.registerLazySingleton(() => GetTvOnTheAir(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));


  ///
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  ///repository movie
  locator.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
  ));

  ///repository tv
  locator.registerLazySingleton<TvRepository>(() => TvRepositoryImpl(
      localDataSource: locator(),
      remoteDataSource: locator(),
      networkInfo: locator(),
  ));

  ///data source
  locator.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImpl(databaseHelper: locator()));

  ///helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  ///network
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  ///external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
