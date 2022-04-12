
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/db/database_helper_tv.dart';
import 'package:core/data/datasources/local/local_data_source.dart';
import 'package:core/data/datasources/local/tv/local_data_source_tv.dart';
import 'package:core/data/datasources/remote/remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/repositories/movie_respository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/domain/usecase/get_watchlist_movies.dart';
import 'package:core/domain/usecase/get_watchlist_status.dart';
import 'package:core/domain/usecase/remove_watchlist.dart';
import 'package:core/domain/usecase/save_watchlist.dart';
import 'package:core/domain/usecase/tv/get_watchlist_status_tv.dart';
import 'package:core/domain/usecase/tv/get_watchlist_tv.dart';
import 'package:core/domain/usecase/tv/remove_watchlist_tv.dart';
import 'package:core/domain/usecase/tv/save_watchlist_tv.dart';
import 'package:core/presentation/provider/tv/watchlist_tv_notifier.dart';
import 'package:core/presentation/provider/watchlist_movie_notifier.dart';
import 'package:movie/presentation/provider/movie_detail_notifier.dart';
import 'package:movie/presentation/provider/movie_list_notifier.dart';
import 'package:movie/presentation/provider/popular_movies_notifier.dart';
import 'package:movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:movie/usecase/get_detail_movie.dart';
import 'package:movie/usecase/get_now_playing_movies.dart';
import 'package:movie/usecase/get_popular_movies.dart';
import 'package:movie/usecase/get_recommended_movie.dart';
import 'package:movie/usecase/get_top_rated_movies.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/use_case/search_movies.dart';
import 'package:search/use_case/search_tv.dart';
import 'package:search/presentation/provider/tv_search_notifier.dart';
import 'package:core/utils/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tv/presentation/provider/tv_airing_today_notifier.dart';
import 'package:tv/presentation/provider/tv_detail_notifier.dart';
import 'package:tv/presentation/provider/tv_list_notifier.dart';
import 'package:tv/presentation/provider/tv_on_the_air_notifier.dart';
import 'package:tv/presentation/provider/tv_popular_notifier.dart';
import 'package:tv/usecase/get_recommendations_tv.dart';
import 'package:tv/usecase/get_tv_airing_today.dart';
import 'package:tv/usecase/get_tv_detail.dart';
import 'package:tv/usecase/get_tv_on_the_air.dart';
import 'package:tv/usecase/get_tv_popular.dart';
import 'package:tv/usecase/get_tv_top_rated.dart';



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
        getTvOnTheAir: locator(),
        getTvPopular: locator(),
        getTvTopRated: locator(),
      ));

  locator.registerFactory(() => TvDetailNotifier(
        getTvDetail: locator(),
        getWatchlistStatusTv: locator(),
        saveWatchlistTv: locator(),
        removeWatchlistTv: locator(),

        getTvRecommendations: locator(),
      ));

  locator.registerFactory(() => MovieDetailNotifier(
        getMovieDetail: locator(),
        getMovieRecommendations: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ));

  ///
  /*locator.registerFactory(() => MovieSearchNotifier(searchMovies: locator()));*/
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(() => TvSearchNotifier(searchTv: locator()));

  //
  locator.registerFactory(() => PopularMoviesNotifier(locator()));
  locator.registerFactory(() => TopRatedMoviesNotifier(getTopRatedMovies: locator()));

  ///
  locator.registerFactory(
      () => WatchlistMovieNotifier(getWatchlistMovies: locator()));
  locator.registerFactory(() => WatchlistTvNotifier(getWatchlistTv: locator()));

  ///
  locator.registerFactory(() => TvOnTheAirNotifier(getTvOnTheAir: locator()));
  locator.registerFactory(() => TvAiringTodayNotifier(getTvAiringToday: locator()));
  locator.registerFactory(() => TvPopularNotifier(locator()));

  ///use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));

  ///
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));

  ///use case tv
  locator.registerLazySingleton(() => GetTvAiringToday(locator()));
  locator.registerLazySingleton(() => GetTvOnTheAir(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvPopular(locator()));
  locator.registerLazySingleton(() => GetTvTopRated(locator()));
  locator.registerLazySingleton(() => GetRecommendationsTv(locator()));


  ///watchlist movie
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  ///watchlist tv
  locator.registerLazySingleton(() => GetWatchlistStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  ///repository movie
  locator.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
        networkInfo: locator(),
      ));

  ///repository tv
  locator.registerLazySingleton<TvRepository>(() => TvRepositoryImpl(
        remoteDataSource: locator(),
        tvLocalDataSource: locator(),
        networkInfo: locator(),
      ));

  ///data source
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelperTv: locator()));

  ///helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTv>(() => DatabaseHelperTv());

  ///network
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  ///external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
