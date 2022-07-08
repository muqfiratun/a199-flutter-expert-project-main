import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/entities/detail_series_tv.dart';
import 'package:ditonton/domain/usecases/get_detail_series_tv.dart';
import 'package:ditonton/domain/usecases/get_recommendations_series_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_series_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series_tv.dart';
import 'package:flutter/cupertino.dart';

class SeriesTvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetDetailSeriesTv getDetailSeriesTv;
  final GetRecommendationsSeriesTv  getRecommendationsSeriesTv;
  final GetWatchListStatusSeriesTv getWatchlistSeriesTv;
  final SaveWatchlistSeriesTv saveWatchlistSeriesTv;
  final RemoveWatchlistSeriesTv removeWatchlistSeriesTv;

  SeriesTvDetailNotifier(
      {required this.getDetailSeriesTv,
        required this.getRecommendationsSeriesTv,
        required this.getWatchlistSeriesTv,
        required this.saveWatchlistSeriesTv,
        required this.removeWatchlistSeriesTv});

  late DetailSeriesTv _detail;
 DetailSeriesTv get detail => _detail;

  RequestState _detailState = RequestState.Empty;
  RequestState get detailState => _detailState;

  List<SeriesTv> _seriesRecommendations = [];
  List<SeriesTv> get seriesRecommendations => _seriesRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvSeriesDetail(int id) async {
    _detailState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getDetailSeriesTv.execute(id);
    final recommendationResult = await getRecommendationsSeriesTv.execute(id);
    detailResult.fold(
          (failure) {
        _detailState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (detail) {
        _recommendationState = RequestState.Loading;
        _detail = detail;
        notifyListeners();
        recommendationResult.fold(
              (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
              (series) {
            _recommendationState = RequestState.Loaded;
            _seriesRecommendations = series;
          },
        );
        _detailState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addSeriesTvWatchlist(DetailSeriesTv series) async {
    final result = await saveWatchlistSeriesTv.execute(series);

    await result.fold(
          (failure) async {
        _watchlistMessage = failure.message;
      },
          (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );
    await loadSeriesTvWatchlistStatus(series.id);
  }

  Future<void> removeFromWatchlist(DetailSeriesTv detail) async{
    final result = await removeWatchlistSeriesTv.execute(detail);

    await result.fold(
          (failure) async {
        _watchlistMessage = failure.message;
      },
          (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadSeriesTvWatchlistStatus(detail.id);
  }

  Future<void> loadSeriesTvWatchlistStatus(int id) async{
    final result = await getWatchlistSeriesTv.execute(id);
    _isAddedtoWatchlist = result;
    print(result);
    notifyListeners();
  }
}
