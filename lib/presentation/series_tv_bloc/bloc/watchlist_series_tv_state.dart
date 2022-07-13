part of 'watchlist_series_tv_bloc.dart';

abstract class WatchlistSeriesTvState extends Equatable {
  const WatchlistSeriesTvState();
  @override
  List<Object> get props => [];
}

class WatchlistSeriesTvEmpty extends WatchlistSeriesTvState {
  @override
  List<Object> get props => [];
}

class WatchlistSeriesTvLoading extends WatchlistSeriesTvState {
  @override
  List<Object> get props => [];
}

class WatchlistSeriesTvError extends WatchlistSeriesTvState {
  String message;
  WatchlistSeriesTvError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistSeriesTvHasData extends WatchlistSeriesTvState {
  final List<SeriesTv> result;

  WatchlistSeriesTvHasData(this.result);

  @override
  List<Object> get props => [result];
}

class InsertWatchlist extends WatchlistSeriesTvState {
  final bool status;

  InsertWatchlist(this.status);

  @override
  List<Object> get props => [status];
}

class MessageWatchlist extends WatchlistSeriesTvState {
  final String message;

  MessageWatchlist(this.message);

  @override
  List<Object> get props => [message];
}
