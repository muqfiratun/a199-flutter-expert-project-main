import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/detail_series_tv.dart';
import 'package:ditonton/domain/repositories/repository_series_tv.dart';

class SaveWatchlistSeriesTv{
  final SeriesTvRepository repository;
  SaveWatchlistSeriesTv(this.repository);

  Future<Either<Failure,String>> execute(DetailSeriesTv series) {
    return repository.saveWatchlistSeriesTv(series);
  }
}