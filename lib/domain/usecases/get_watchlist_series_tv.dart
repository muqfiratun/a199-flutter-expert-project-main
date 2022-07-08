import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/repositories/repository_series_tv.dart';

class GetWatchListSeriesTv{
  final SeriesTvRepository _repository;
  GetWatchListSeriesTv(this._repository);

  Future<Either<Failure,List<SeriesTv>>> execute() {
    return _repository.getWatchlistSeriesTv();
  }
}