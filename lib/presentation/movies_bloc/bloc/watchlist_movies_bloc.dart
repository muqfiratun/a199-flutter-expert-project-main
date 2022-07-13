import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListMovieStatus;
  final RemoveWatchlist _removeWatchlistMovie;
  final SaveWatchlist _saveWatchlistMovie;

  WatchlistMoviesBloc(
      this._getWatchlistMovies,
      this._getWatchListMovieStatus,
      this._removeWatchlistMovie,
      this._saveWatchlistMovie,
      ) : super(WatchlistMoviesEmpty()) {
    on<OnWatchlistMovies>((event, emit) async {
      emit(WatchlistMoviesLoading());

      final result = await _getWatchlistMovies.execute();

      result.fold(
            (failure) {
          emit(WatchlistMoviesError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(WatchlistMoviesEmpty());
          } else {
            emit(WatchlistMoviesHasData(data));
          }
        },
      );
    });

    on<WatchlistMovies>((event, emit) async {
      final id = event.id;

      final result = await _getWatchListMovieStatus.execute(id);

      emit(InsertWatchlist(result));
    });

    on<InsertWatchlistMovies>((event, emit) async {
      emit(WatchlistMoviesLoading());
      final movie = event.movie;

      final result = await _saveWatchlistMovie.execute(movie);

      result.fold(
            (failure) {
          emit(WatchlistMoviesError(failure.message));
        },
            (message) {
          emit(MessageWatchlist(message));
        },
      );
    });

    on<DeleteWatchlistMovies>((event, emit) async {
      final movie = event.movie;

      final result = await _removeWatchlistMovie.execute(movie);

      result.fold(
            (failure) {
          emit(WatchlistMoviesError(failure.message));
        },
            (message) {
          emit(MessageWatchlist(message));
        },
      );
    });
  }
}