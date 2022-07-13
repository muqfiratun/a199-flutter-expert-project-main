part of 'watchlist_series_tv_bloc.dart';

abstract class WatchlistSeriesTvEvent extends Equatable {
  const WatchlistSeriesTvEvent();
}

class OnWatchlistSeriesTv extends WatchlistSeriesTvEvent {
  @override
  List<Object> get props => [];
}

class WatchlistSeriesTv extends WatchlistSeriesTvEvent {
  final int id;

  WatchlistSeriesTv(this.id);

  @override
  List<Object> get props => [id];
}

class InsertWatchlistSeriesTv extends WatchlistSeriesTvEvent {
  final DetailSeriesTv movie;

  InsertWatchlistSeriesTv(this.movie);

  @override
  List<Object> get props => [movie];
}

class DeleteWatchlistSeriesTv extends WatchlistSeriesTvEvent {
  final DetailSeriesTv movie;

  DeleteWatchlistSeriesTv(this.movie);

  @override
  List<Object> get props => [movie];
}