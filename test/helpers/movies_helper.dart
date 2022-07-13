import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/detail_movies_bloc.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/recommendations_movies_bloc.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/watchlist_movies_bloc.dart';
import 'package:mocktail/mocktail.dart';

// Now Playing
class FakeNowPlayingMoviesEvent extends Fake implements NowPlayingMoviesEvent {}

class FakeNowPlayingMoviestate extends Fake implements NowPlayingMoviesState {}

class FakeNowPlayingMoviesBloc
    extends MockBloc<NowPlayingMoviesEvent, NowPlayingMoviesState>
    implements NowPlayingMoviesBloc {}

// Popular
class FakePopularMoviesEvent extends Fake implements PopularMoviesEvent {}

class FakePopularMoviesState extends Fake implements PopularMoviesState {}

class FakePopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

// Top Rated
class FakeTopRatedMoviesEvent extends Fake implements TopRatedMoviesEvent {}

class FakeTopRatedMoviesState extends Fake implements TopRatedMoviesState {}

class FakeTopRatedMoviesBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

// Detail Movie
class FakeDetailMoviesEvent extends Fake implements DetailMoviesEvent {}

class FakeDetailMoviesState extends Fake implements DetailMoviesState {}

class FakeDetailMoviesBloc extends MockBloc<DetailMoviesEvent, DetailMoviesState>
    implements DetailMoviesBloc {}

// Recomendation
class FakeRecommendationsMoviesEvent extends Fake
    implements RecommendationMoviesEvent {}

class FakeRecommendationsMoviesState extends Fake
    implements RecommendationMoviesState {}

class FakeRecommendationsMoviesBloc
    extends MockBloc<RecommendationMoviesEvent, RecommendationMoviesState>
    implements RecommendationMoviesBloc {}

// Watch List
class FakeWatchlistMoviesEvent extends Fake implements WatchlistMoviesEvent {}

class FakeWatchlistMoviesState extends Fake implements WatchlistMoviesState {}

class FakeWatchlistMoviesBloc
    extends MockBloc<WatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}