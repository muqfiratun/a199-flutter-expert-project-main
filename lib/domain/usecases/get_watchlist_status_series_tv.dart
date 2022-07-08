import 'package:ditonton/domain/repositories/repository_series_tv.dart';

class GetWatchListStatusSeriesTv{
  final SeriesTvRepository repository;
  GetWatchListStatusSeriesTv(this.repository);

  Future<bool> execute(int id) async{
    return repository.seriesTvIsAddedToWatchlist(id);
  }
}