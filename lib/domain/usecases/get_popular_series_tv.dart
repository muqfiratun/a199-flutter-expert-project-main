import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/repositories/repository_series_tv.dart';

class GetTvPopular{
  final SeriesTvRepository repository;

  GetTvPopular(this.repository);

  Future<Either<Failure,List<SeriesTv>>> execute() {
    return repository.getTvPopular();
  }
}