part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();
}

class OnWatchlistMovies extends WatchlistMoviesEvent {
  @override
  List<Object> get props => [];
}

class WatchlistMovies extends WatchlistMoviesEvent {
  final int id;

  WatchlistMovies(this.id);

  @override
  List<Object> get props => [id];
}

class InsertWatchlistMovies extends WatchlistMoviesEvent {
  final MovieDetail movie;

  InsertWatchlistMovies(this.movie);

  @override
  List<Object> get props => [movie];
}

class DeleteWatchlistMovies extends WatchlistMoviesEvent {
  final MovieDetail movie;

  DeleteWatchlistMovies(this.movie);

  @override
  List<Object> get props => [movie];
}