import 'package:about/about.dart';
import 'package:core/presentation/pages/movies/home_page.dart';
import 'package:core/presentation/pages/movies/movie_detail_page.dart';
import 'package:core/presentation/pages/movies/popular_movies_page.dart';
import 'package:core/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:core/presentation/pages/tv/airing_today_page.dart';
import 'package:core/presentation/pages/tv/popular_tv_page.dart';
import 'package:core/presentation/pages/tv/tv_detail_page.dart';
import 'package:core/presentation/pages/tv/tv_on_the_air_page.dart';
import 'package:core/presentation/pages/tv/tv_page.dart';
import 'package:core/presentation/pages/watchlist/tab_pager.dart';
import 'package:core/presentation/pages/watchlist/watchlist_page.dart';
import 'package:core/presentation/pages/watchlist/watchlist_tv_page.dart';
import 'package:core/presentation/provider/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movie_list_notifier.dart';
import 'package:core/presentation/provider/popular_movies_notifier.dart';
import 'package:core/presentation/provider/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/tv/tv_airing_today_notifier.dart';
import 'package:core/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:core/presentation/provider/tv/tv_list_notifier.dart';
import 'package:core/presentation/provider/tv/tv_on_the_air_notifier.dart';
import 'package:core/presentation/provider/tv/tv_popular_notifier.dart';
import 'package:core/presentation/provider/tv/watchlist_tv_notifier.dart';
import 'package:core/presentation/provider/watchlist_movie_notifier.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_style.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/page/search/search_page.dart';
import 'package:search/presentation/page/search/search_tv_page.dart';
import 'package:search/presentation/provider/movie_search_notifier.dart';
import 'package:search/presentation/provider/tv_search_notifier.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvOnTheAirNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvAiringTodayNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvPopularNotifier>(),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
            colorScheme: kColorScheme,
            primaryColor: kRichBlack,
            accentColor: kYellow,
            scaffoldBackgroundColor: kRichBlack,
            textTheme: textTheme),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.routeName:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(id: id), settings: settings);
            case TvDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => TvDetailPage(id: id), settings: settings);
            case PopularMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => TopRatedMoviesPage());
            case TvOnTheAirPage.routeName:
              return MaterialPageRoute(builder: (_) => TvOnTheAirPage());
            case AiringTodayPage.routeName:
              return MaterialPageRoute(builder: (_) => AiringTodayPage());
            case PopularTvPage.routeName:
              return MaterialPageRoute(builder: (_) => PopularTvPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case SearchPage.routeName:
              return MaterialPageRoute(builder: (_) => SearchPage());
            case SearchTvPage.routeName:
              return MaterialPageRoute(builder: (_) => SearchTvPage());
            case WatchlistPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case WatchlistTvPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());
            case TabPager.routeName:
              return MaterialPageRoute(builder: (_) => TabPager());
            case TvPage.routeName:
              return MaterialPageRoute(builder: (_) => TvPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found!'),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
