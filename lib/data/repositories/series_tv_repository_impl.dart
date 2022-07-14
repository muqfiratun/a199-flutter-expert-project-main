import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/datasources/series_tv_local_data_source.dart';
import 'package:ditonton/data/datasources/series_tv_remote_data_source.dart';
import 'package:ditonton/data/models/table_series_tv.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/entities/detail_series_tv.dart';
import 'package:ditonton/domain/repositories/repository_series_tv.dart';

class SeriesTvRepositoryImpl implements SeriesTvRepository {
  final RemoteSeriesTvDataSource remoteDataSource;
  final SeriesTvLocalSource localDataSource;

  SeriesTvRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure,List<SeriesTv>>> getNowPlayingSeriesTv() async{
    try{
      final result = await remoteDataSource.getNowPlayingSeriesTv();
      return Right(result.map((model)=>model.toEntity()).toList());
    } on ServerException{
      return Left(ServerFailure(''));
    } on SocketException{
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException{
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure,DetailSeriesTv>> getDetailSeriesTv(int id) async{
    try{
      final result = await remoteDataSource.getDetailSeriesTv(id);
      return Right(result.toEntity());
    } on ServerException{
      return Left(ServerFailure(''));
    } on SocketException{
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException{
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure,List<SeriesTv>>> getRecommendationsSeriesTv(int id) async{
    try{
      final result = await remoteDataSource.getRecommendationsSeriesTv(id);
      return Right(result.map((model)=>model.toEntity()).toList());
    } on ServerException{
      return Left(ServerFailure(''));
    } on SocketException{
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException{
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure,List<SeriesTv>>> getTopRatedSeriesTv() async{
    try{
      final result = await remoteDataSource.getTopRatedSeriesTv();
      return Right(result.map((model)=>model.toEntity()).toList());
    } on ServerException{
      return Left(ServerFailure(''));
    } on SocketException{
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException{
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure,List<SeriesTv>>> searchSeriesTv(String query) async{
    try{
      final result = await remoteDataSource.searchSeriesTv(query);
      return Right(result.map((model)=>model.toEntity()).toList());
    } on ServerException{
      return Left(ServerFailure(''));
    } on SocketException{
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException{
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure,List<SeriesTv>>> getTvPopular() async{
    try{
      final result = await remoteDataSource.getPopularSeriesTv();
      return Right(result.map((model)=>model.toEntity()).toList());
    } on ServerException{
      return Left(ServerFailure(''));
    } on SocketException{
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException{
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure,String>> saveWatchlistSeriesTv(DetailSeriesTv series) async{
    try{
      final result = await localDataSource.insertWatchlistSeriesTv(TableSeriesTv.fromEntity(series));
      return Right(result);
    } on DatabaseException catch (e){
      return Left(DatabaseFailure(e.message));
    } catch (e){
      throw e;
    }
  }

  @override
  Future<Either<Failure,String>> removeWatchlistSeriesTv(DetailSeriesTv series) async{
    try{
      final result = await localDataSource.removeWatchlistSeriesTv(TableSeriesTv.fromEntity(series));
      return Right(result);
    } on DatabaseException catch (e){
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> seriesTvIsAddedToWatchlist (int id) async{
    final result = await localDataSource.getSeriesTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<SeriesTv>>> getWatchlistSeriesTv() async {
    final result = await localDataSource.getWatchlistSeriesTv();
    return Right(result.map((data) => data.toEntity()).toList());
  }

}
