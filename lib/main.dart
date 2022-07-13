import 'dart:io';
import 'package:ditonton/common/constants.dart';
//import 'package:ditonton/common/ssl_pinning.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/home_page_series_tv.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_page_series_tv.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_page_series_tv.dart';
import 'package:ditonton/presentation/pages/detail_page_series_tv.dart';
import 'package:ditonton/presentation/pages/search_page_series_tv.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page_series_tv.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/detail_movies_bloc.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/recommendations_movies_bloc.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/search_movies_bloc.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/airing_today_series_tv_bloc.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/popular_series_tv_bloc.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/recommendations_series_tv_bloc.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/search_series_tv_bloc.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/detail_series_tv_bloc.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/top_rated_series_tv_bloc.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/watchlist_series_tv_bloc.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await HttpSSLPinning.init();
  HttpOverrides.global = MyHttpOverrides();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        // tv series bloc
        BlocProvider(
          create: (_) => di.locator<SearchSeriesTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularSeriesTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedSeriesTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailSeriesTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationSeriesTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistSeriesTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<AiringTodaySeriesTvBloc>(),
        ),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case HomeSeriesTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_)=>HomeSeriesTvPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case PopularPageSeriesTv.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularPageSeriesTv());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TopRatedPageSeriesTv.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedPageSeriesTv());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case DetailPageSeriesTv.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => DetailPageSeriesTv(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchPageSeriesTv.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPageSeriesTv());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistPageSeriesTv.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPageSeriesTv());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
