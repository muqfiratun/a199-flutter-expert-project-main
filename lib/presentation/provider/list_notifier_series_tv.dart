import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_series_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series_tv.dart';
import 'package:flutter/cupertino.dart';

class ListNotifierSeriesTv extends ChangeNotifier {
  var _nowPlayingSeriesTv = <SeriesTv>[];
  List<SeriesTv> get nowPlayingSeriesTv => _nowPlayingSeriesTv;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTv = <SeriesTv>[];
  List<SeriesTv> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  var _topRatedSeriesTv = <SeriesTv>[];
  List<SeriesTv> get topRatedSeriesTv => _topRatedSeriesTv;

  RequestState _topRatedStateSeriesTv = RequestState.Empty;
  RequestState get topRatedStateSeriesTv => _topRatedStateSeriesTv;

  String _message = '';
  String get message => _message;

  final GetNowPlayingSeriesTv getNowPlayingSeriesTv;
  final GetTvPopular getTvPopular;
  final GetTopRatedSeriesTv getTopRatedSeriesTv;

  ListNotifierSeriesTv({
    required this.getTopRatedSeriesTv,
    required this.getTvPopular,
    required this.getNowPlayingSeriesTv,
  });

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingSeriesTv.execute();
    result.fold(
          (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (moviesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingSeriesTv = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTv() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getTvPopular.execute();
    result.fold(
          (failure) {
        _popularTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (tvData) {
        _popularTvState = RequestState.Loaded;
        _popularTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    _topRatedStateSeriesTv = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedSeriesTv.execute();
    result.fold(
          (failure) {
       _topRatedStateSeriesTv = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (seriesData) {
        _topRatedStateSeriesTv = RequestState.Loaded;
        _topRatedSeriesTv= seriesData;
        notifyListeners();
      },
    );
  }
}