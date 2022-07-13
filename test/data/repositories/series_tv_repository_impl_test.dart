import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/model_season_tv.dart';
import 'package:ditonton/data/models/detail_model_series_tv.dart';
import 'package:ditonton/data/models/model_series_tv.dart';
import 'package:ditonton/data/repositories/series_tv_repository_impl.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SeriesTvRepositoryImpl repository;
  late MockRemoteSeriesTvDataSource mockRemoteDataSource;
  late MockSeriesTvLocalSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteSeriesTvDataSource();
    mockLocalDataSource = MockSeriesTvLocalSource();
    repository = SeriesTvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tSeriesTvModel = SeriesTvModel(
    backdropPath: 'backdropPath',
    firstAirDate: "2021-09-03",
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ["US"],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 18.591,
    posterPath: 'posterPath',
    voteAverage: 9.4,
    voteCount: 2710,
  );

  final tSeries = SeriesTv(
    backdropPath: 'backdropPath',
    firstAirDate: "2021-09-03",
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ["US"],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 18.591,
    posterPath: 'posterPath',
    voteAverage: 9.4,
    voteCount: 2710,
  );

  final tSeriesTvModelList = <SeriesTvModel>[tSeriesTvModel];
  final tSeriesTvList = <SeriesTv>[tSeries];

  group('Now Playing Tv Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingSeriesTv())
              .thenAnswer((_) async => tSeriesTvModelList);
          // act
          final result = await repository.getNowPlayingSeriesTv();
          // assert
          verify(mockRemoteDataSource.getNowPlayingSeriesTv());
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tSeriesTvList);
        });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingSeriesTv())
              .thenThrow(ServerException());
          // act
          final result = await repository.getNowPlayingSeriesTv();
          // assert
          verify(mockRemoteDataSource.getNowPlayingSeriesTv());
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingSeriesTv())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getNowPlayingSeriesTv();
          // assert
          verify(mockRemoteDataSource.getNowPlayingSeriesTv());
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Popular Tv Series', () {
    test('should return tv series list when call to data source is success',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularSeriesTv())
              .thenAnswer((_) async => tSeriesTvModelList);
          // act
          final result = await repository.getTvPopular();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tSeriesTvList);
        });

    test(
        'should return server failure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularSeriesTv())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvPopular();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return connection failure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularSeriesTv())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvPopular();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Top Rated Tv Series', () {
    test('should return Tv Series list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedSeriesTv())
              .thenAnswer((_) async => tSeriesTvModelList);
          // act
          final result = await repository.getTopRatedSeriesTv();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tSeriesTvList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedSeriesTv())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTopRatedSeriesTv();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedSeriesTv())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTopRatedSeriesTv();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Get Tv Series Detail', () {
    final tId = 1;
    final tSeriesTvResponse = DetailResponseSeriesTv(
      adult: false,
      backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
      episodeRunTime: [42],
      genres: [GenreModel(id: 18, name: 'Drama')],
      homepage: "https://www.telemundo.com/shows/pasion-de-gavilanes",
      id: 1,
      name: "name",
      numberOfEpisodes: 259,
      numberOfSeasons: 2,
      originalName: "Pasión de gavilanes",
      overview: "overview",
      popularity: 1747.047,
      posterPath: "posterPath",
      seasons: [
        SeasonTvModel(
          episodeCount: 188,
          id: 72643,
          name: "Season 1",
          posterPath: "/elrDXqvMIX3EcExwCenQMVVmnvd.jpg",
          seasonNumber: 1,
        )
      ],
      status: "Returning Series",
      type: "Scripted",
      voteAverage: 7.6,
      voteCount: 1803,
    );

    test(
        'should return Tv Series data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getDetailSeriesTv(tId))
              .thenAnswer((_) async => tSeriesTvResponse);
          // act
          final result = await repository.getDetailSeriesTv(tId);
          // assert
          verify(mockRemoteDataSource.getDetailSeriesTv(tId));
          expect(result, equals(Right(testSeriesTvDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getDetailSeriesTv(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getDetailSeriesTv(tId);
          // assert
          verify(mockRemoteDataSource.getDetailSeriesTv(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getDetailSeriesTv(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getDetailSeriesTv(tId);
          // assert
          verify(mockRemoteDataSource.getDetailSeriesTv(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get Tv Series Recommendations', () {
    final tSeriesTvList = <SeriesTvModel>[];
    final tId = 1;

    test('should return data (tv series list) when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getRecommendationsSeriesTv(tId))
              .thenAnswer((_) async => tSeriesTvList);
          // act
          final result = await repository.getRecommendationsSeriesTv(tId);
          // assert
          verify(mockRemoteDataSource.getRecommendationsSeriesTv(tId));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tSeriesTvList));
        });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getRecommendationsSeriesTv(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getRecommendationsSeriesTv(tId);
          // assertbuild runner
          verify(mockRemoteDataSource.getRecommendationsSeriesTv(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getRecommendationsSeriesTv(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getRecommendationsSeriesTv(tId);
          // assert
          verify(mockRemoteDataSource.getRecommendationsSeriesTv(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Seach Tv Series', () {
    final tQuery = 'Halo';

    test('should return tv series list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchSeriesTv(tQuery))
              .thenAnswer((_) async => tSeriesTvModelList);
          // act
          final result = await repository.searchSeriesTv(tQuery);
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tSeriesTvList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchSeriesTv(tQuery))
              .thenThrow(ServerException());
          // act
          final result = await repository.searchSeriesTv(tQuery);
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.searchSeriesTv(tQuery))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.searchSeriesTv(tQuery);
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('save Tv Series watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistSeriesTv(testSeriesTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlistSeriesTv(testSeriesTvDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistSeriesTv(testSeriesTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistSeriesTv(testSeriesTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistSeriesTv(testSeriesTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result =
      await repository.removeWatchlistSeriesTv(testSeriesTvDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistSeriesTv(testSeriesTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result =
      await repository.removeWatchlistSeriesTv(testSeriesTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getSeriesTvById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.seriesTvIsAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist Tv Series', () {
    test('should return list of Tv Series', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistSeriesTv())
          .thenAnswer((_) async => [testSeriesTvTable]);
      // act
      final result = await repository.getWatchlistSeriesTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistSeriesTv]);
    });
  });
}