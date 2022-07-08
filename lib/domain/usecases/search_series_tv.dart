import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/repositories/repository_series_tv.dart';

class SearchSeriesTv{
  final SeriesTvRepository repository;

  SearchSeriesTv(this.repository);

  Future<Either<Failure,List<SeriesTv>>> execute(String query) {
    return repository.searchSeriesTv(query);
  }
}