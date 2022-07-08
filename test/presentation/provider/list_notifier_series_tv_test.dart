import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_series_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series_tv.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/list_notifier_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'list_notifier_series_tv_test.mocks.dart';

@GenerateMocks([GetNowPlayingSeriesTv, GetTvPopular, GetTopRatedSeriesTv])
void main() {
  late ListNotifierSeriesTv provider;
  late MockGetNowPlayingSeriesTv mockGetNowPlayingSeriesTv;
  late MockGetTvPopular mockGetPopularSeriesTv;
  late MockGetTopRatedSeriesTv mockGetTopRatedSeriesTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingSeriesTv = MockGetNowPlayingSeriesTv();
    mockGetPopularSeriesTv = MockGetTvPopular();
    mockGetTopRatedSeriesTv = MockGetTopRatedSeriesTv();
    provider = ListNotifierSeriesTv(
      getNowPlayingSeriesTv: mockGetNowPlayingSeriesTv,
      getTvPopular: mockGetPopularSeriesTv,
      getTopRatedSeriesTv: mockGetTopRatedSeriesTv,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tSeries = SeriesTv(
    backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
    firstAirDate: "2003-10-21",
    genreIds: [18],
    id: 11250,
    name: "Hidden Passion",
    originCountry: ["CO"],
    originalLanguage: "es",
    originalName: "Pasión de gavilanes",
    overview:
    "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
    popularity: 1747.047,
    posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
    voteAverage: 7.6,
    voteCount: 1803,
  );

  final tSeriesList = <SeriesTv>[tSeries];

  group('on the air tv series', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingSeriesTv.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchNowPlayingMovies();
      // assert
      verify(mockGetNowPlayingSeriesTv.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingSeriesTv.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchNowPlayingMovies();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingSeriesTv.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchNowPlayingMovies();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingSeriesTv, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingSeriesTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingMovies();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv serires', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularSeriesTv.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tv series data when data is gotten successfully',
            () async {
          // arrange
          when(mockGetPopularSeriesTv.execute())
              .thenAnswer((_) async => Right(tSeriesList));
          // act
          await provider.fetchPopularTv();
          // assert
          expect(provider.popularTvState, RequestState.Loaded);
          expect(provider.popularTv, tSeriesList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularSeriesTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedSeriesTv.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchTopRatedMovies();
      // assert
      expect(provider.topRatedStateSeriesTv, RequestState.Loading);
    });

    test('should change tv series data when data is gotten successfully',
            () async {
          // arrange
          when(mockGetTopRatedSeriesTv.execute())
              .thenAnswer((_) async => Right(tSeriesList));
          // act
          await provider.fetchTopRatedMovies();
          // assert
          expect(provider.topRatedStateSeriesTv, RequestState.Loaded);
          expect(provider.topRatedSeriesTv, tSeriesList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedSeriesTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedMovies();
      // assert
      expect(provider.topRatedStateSeriesTv, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}