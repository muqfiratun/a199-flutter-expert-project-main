import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series_tv.dart';
import 'package:flutter/cupertino.dart';

class TopRatedNotifierSeriesTv extends ChangeNotifier{
  final GetTopRatedSeriesTv getTopRatedSeriesTv;
  TopRatedNotifierSeriesTv({required this.getTopRatedSeriesTv});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<SeriesTv> _series = [];
  List<SeriesTv> get movies => _series;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvSeries() async{
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedSeriesTv.execute();

    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (seriesData) {
        _series = seriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}