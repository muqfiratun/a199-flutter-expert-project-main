import 'package:ditonton/common/ssl_pinning.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/series_tv_local_data_source.dart';
import 'package:ditonton/data/datasources/series_tv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/series_tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/repository_series_tv.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_series_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series_tv.dart';
import 'package:ditonton/domain/usecases/get_detail_series_tv.dart';
import 'package:ditonton/domain/usecases/get_recommendations_series_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_series_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_series_tv.dart';
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
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  //bloc movies
  locator.registerFactory(() => DetailMoviesBloc(locator(),),);
  locator.registerFactory(() => RecommendationMoviesBloc(locator(),),);
  locator.registerFactory(() => SearchMoviesBloc(locator(),),);
  locator.registerFactory(() => NowPlayingMoviesBloc(locator(),),);
  locator.registerFactory(() => PopularMoviesBloc(locator(),),);
  locator.registerFactory(() => TopRatedMoviesBloc(locator(),),);
  locator.registerFactory(() => WatchlistMoviesBloc(locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  //bloc tv series
  locator.registerFactory(() => DetailSeriesTvBloc(locator(),),);
  locator.registerFactory(() => RecommendationSeriesTvBloc(locator(),),);
  locator.registerFactory(() => SearchSeriesTvBloc(locator(),),);
  locator.registerFactory(() => AiringTodaySeriesTvBloc(locator(),),);
  locator.registerFactory(() => PopularSeriesTvBloc(locator(),),);
  locator.registerFactory(() => TopRatedSeriesTvBloc(locator(),),);
  locator.registerFactory(() => WatchlistSeriesTvBloc(locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // use case
  //MOVIE
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  //SeriesTv
  locator.registerLazySingleton(() => GetNowPlayingSeriesTv(locator()));
  locator.registerLazySingleton(() => GetTvPopular(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeriesTv(locator()));
  locator.registerLazySingleton(() => GetDetailSeriesTv(locator()));
  locator.registerLazySingleton(() => GetRecommendationsSeriesTv(locator()));
  locator.registerLazySingleton(() => SearchSeriesTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusSeriesTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistSeriesTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistSeriesTv(locator()));
  locator.registerLazySingleton(() => GetWatchListSeriesTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<SeriesTvRepository>(
        () => SeriesTvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
          () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<RemoteSeriesTvDataSource>(
          () => RemoteSeriesTvDataSourceImpl(client: locator()));
  locator.registerLazySingleton<SeriesTvLocalSource>(
          () => SeriesTvLocalSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
