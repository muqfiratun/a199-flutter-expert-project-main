import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/detail_series_tv.dart';
import 'package:ditonton/domain/repositories/repository_series_tv.dart';

class GetDetailSeriesTv{
  final SeriesTvRepository repository;

  GetDetailSeriesTv(this.repository);

  Future<Either<Failure, DetailSeriesTv>> execute(int id){
    return repository.getDetailSeriesTv(id);
  }
}