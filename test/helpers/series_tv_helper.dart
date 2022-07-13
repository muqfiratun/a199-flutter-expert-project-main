import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/airing_today_series_tv_bloc.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/detail_series_tv_bloc.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/popular_series_tv_bloc.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/recommendations_series_tv_bloc.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/top_rated_series_tv_bloc.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/watchlist_series_tv_bloc.dart';
import 'package:mocktail/mocktail.dart';

// Airing Today
class FakeOnTheAirNowSeriesTvEvent extends Fake
    implements AiringTodaySeriesTvEvent {}

class FakeOnTheAirNowSeriesTvState extends Fake
    implements AiringTodaySeriesTvState {}

class FakeOnTheAirNowSeriesTvBloc
    extends MockBloc<AiringTodaySeriesTvEvent, AiringTodaySeriesTvState>
    implements AiringTodaySeriesTvBloc {}

// Popular
class FakePopularSeriesTvEvent extends Fake implements PopularSeriesTvEvent {}

class FakePopularSeriesTvState extends Fake implements PopularSeriesTvState {}

class FakePopularSeriesTvBloc
    extends MockBloc<PopularSeriesTvEvent, PopularSeriesTvState>
    implements PopularSeriesTvBloc {}

// Top Rated
class FakeTopRatedSeriesTvEvent extends Fake implements TopRatedSeriesTvEvent {}

class FakeTopRatedSeriesTvState extends Fake implements TopRatedSeriesTvState {}

class FakeTopRatedSeriesTvBloc
    extends MockBloc<TopRatedSeriesTvEvent, TopRatedSeriesTvState>
    implements TopRatedSeriesTvBloc {}

// Detail Tv Series
class FakeSeriesTvDetailEvent extends Fake implements DetailSeriesTvEvent {}

class FakeSeriesTvDetailState extends Fake implements DetailSeriesTvState {}

class FakeDetailSeriesTvBloc
    extends MockBloc<DetailSeriesTvEvent, DetailSeriesTvState>
    implements DetailSeriesTvBloc {}

// Recomendaion
class FakeSeriesTvRecommendationsEvent extends Fake
    implements RecommendationSeriesTvEvent {}

class FakeSeriesTvRecommendationsState extends Fake
    implements RecommendationSeriesTvState {}

class FakeSeriesTvRecommendationsBloc
    extends MockBloc<RecommendationSeriesTvEvent, RecommendationSeriesTvState>
    implements RecommendationSeriesTvBloc {}

// Watch List
class FakeWatchlistSeriesTvEvent extends Fake
    implements WatchlistSeriesTvEvent {}

class FakeWatchlistSeriesTvState extends Fake
    implements WatchlistSeriesTvState {}

class FakeWatchlistSeriesTvBloc
    extends MockBloc<WatchlistSeriesTvEvent, WatchlistSeriesTvState>
    implements WatchlistSeriesTvBloc {}