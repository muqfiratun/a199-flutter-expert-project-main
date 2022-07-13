import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/entities/detail_series_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_series_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series_tv.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_series_tv_event.dart';
part 'watchlist_series_tv_state.dart';

class WatchlistSeriesTvBloc extends Bloc<WatchlistSeriesTvEvent, WatchlistSeriesTvState> {
  final GetWatchListSeriesTv _getWatchlistSeriesTv;
  final GetWatchListStatusSeriesTv _getWatchListStatusSeriesTv;
  final RemoveWatchlistSeriesTv _removeWatchlistSeriesTv;
  final SaveWatchlistSeriesTv _saveWatchlistSeriesTv;

  WatchlistSeriesTvBloc(
      this._getWatchlistSeriesTv,
      this._getWatchListStatusSeriesTv,
      this._removeWatchlistSeriesTv,
      this._saveWatchlistSeriesTv,
      ) : super(WatchlistSeriesTvEmpty()) {
    on<OnWatchlistSeriesTv>((event, emit) async {
      emit(WatchlistSeriesTvLoading());

      final result = await _getWatchlistSeriesTv.execute();

      result.fold(
            (failure) {
          emit(WatchlistSeriesTvError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(WatchlistSeriesTvEmpty());
          } else {
            emit(WatchlistSeriesTvHasData(data));
          }
        },
      );
    });

    on<WatchlistSeriesTv>((event, emit) async {

      final id = event.id;

      final result = await _getWatchListStatusSeriesTv.execute(id);

      emit(InsertWatchlist(result));
    });

    on<InsertWatchlistSeriesTv>((event, emit) async {
      emit(WatchlistSeriesTvLoading());
      final movie = event.movie;

      final result = await _saveWatchlistSeriesTv.execute(movie);

      result.fold(
            (failure) {
          emit(WatchlistSeriesTvError(failure.message));
        },
            (message) {
          emit(MessageWatchlist(message));
        },
      );
    });

    on<DeleteWatchlistSeriesTv>((event, emit) async {
      final movie = event.movie;

      final result = await _removeWatchlistSeriesTv.execute(movie);

      result.fold(
            (failure) {
          emit(WatchlistSeriesTvError(failure.message));
        },
            (message) {
          emit(MessageWatchlist(message));
        },
      );
    });
  }
}
