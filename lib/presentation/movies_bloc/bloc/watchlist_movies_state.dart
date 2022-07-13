part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();
  @override
  List<Object> get props => [];
}


class WatchlistMoviesEmpty extends WatchlistMoviesState {
  @override
  List<Object> get props => [];
}

class WatchlistMoviesLoading extends WatchlistMoviesState {
  @override
  List<Object> get props => [];
}

class WatchlistMoviesError extends WatchlistMoviesState {
  String message;
  WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMoviesHasData extends WatchlistMoviesState {
  final List<Movie> result;

  WatchlistMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class InsertWatchlist extends WatchlistMoviesState {
  final bool status;

  InsertWatchlist(this.status);

  @override
  List<Object> get props => [status];
}

class MessageWatchlist extends WatchlistMoviesState {
  final String message;

  MessageWatchlist(this.message);

  @override
  List<Object> get props => [message];
}
