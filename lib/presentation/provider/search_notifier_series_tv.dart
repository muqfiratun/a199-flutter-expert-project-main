import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/search_series_tv.dart';
import 'package:flutter/cupertino.dart';

class SearchNotifierSeriesTv extends ChangeNotifier{
  final SearchSeriesTv searchSeriesTv;
  SearchNotifierSeriesTv({required this.searchSeriesTv});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<SeriesTv> _searchResult = [];
  List<SeriesTv> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeriesSearch(String query) async{
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchSeriesTv.execute(query);
    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}