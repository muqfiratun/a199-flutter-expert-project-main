import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series_tv.dart';
import 'package:flutter/cupertino.dart';

class WatchlistSeriesTvNotifier extends ChangeNotifier {
  var _watchlistTvSeries = <SeriesTv>[];
  List<SeriesTv> get watchlistTvSeries => _watchlistTvSeries;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistSeriesTvNotifier({required this.getWatchListSeriesTv});

  final GetWatchListSeriesTv getWatchListSeriesTv;

  Future<void> fetchWatchlistTvSeries() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchListSeriesTv.execute();
    result.fold(
          (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (data) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvSeries = data;
        notifyListeners();
      },
    );
  }
}
