import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/entities/detail_series_tv.dart';

abstract class SeriesTvRepository{
  Future<Either<Failure, List<SeriesTv>>> getTvPopular();
  Future<Either<Failure, List<SeriesTv>>> getNowPlayingSeriesTv();
  Future<Either<Failure, List<SeriesTv>>> getTopRatedSeriesTv();
  Future<Either<Failure, List<SeriesTv>>> getRecommendationsSeriesTv(int id);
  Future<Either<Failure, List<SeriesTv>>> searchSeriesTv(String query);
  Future<Either<Failure, DetailSeriesTv>> getDetailSeriesTv(int id);
  Future<Either<Failure, String>> saveWatchlistSeriesTv(DetailSeriesTv series);
  Future<Either<Failure, String>> removeWatchlistSeriesTv(DetailSeriesTv series);
  Future<bool> seriesTvIsAddedToWatchlist(int id);
  Future<Either<Failure, List<SeriesTv>>> getWatchlistSeriesTv();

}