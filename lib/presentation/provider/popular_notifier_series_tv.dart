import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_series_tv.dart';
import 'package:flutter/cupertino.dart';

class PopularTvNotifier extends ChangeNotifier {
  final GetTvPopular getPopularTv;
  PopularTvNotifier(this.getPopularTv);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<SeriesTv> _tvSeries = [];
  List<SeriesTv> get series => _tvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();

    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (seriesData) {
        _tvSeries = seriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
