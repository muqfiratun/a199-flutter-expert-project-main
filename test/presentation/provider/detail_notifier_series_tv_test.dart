import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_detail_series_tv.dart';
import 'package:ditonton/domain/usecases/get_recommendations_series_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_series_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series_tv.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/detail_notifier_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import 'detail_notifier_series_tv_test.mocks.dart';

@GenerateMocks([
  GetDetailSeriesTv,
  GetRecommendationsSeriesTv,
  GetWatchListStatusSeriesTv,
  SaveWatchlistSeriesTv,
  RemoveWatchlistSeriesTv,
])
void main() {
  late SeriesTvDetailNotifier provider;
  late MockGetDetailSeriesTv mockGetDetailSeriesTv;
  late MockGetRecommendationsSeriesTv mockGetRecommendationsSeriesTv;
  late MockGetWatchListStatusSeriesTv mockGetWatchListStatusSeriesTv;
  late MockSaveWatchlistSeriesTv mockSaveWatchlistSeriesTv;
  late MockRemoveWatchlistSeriesTv mockRemoveWatchlistSeriesTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetDetailSeriesTv = MockGetDetailSeriesTv();
    mockGetRecommendationsSeriesTv = MockGetRecommendationsSeriesTv();
    mockGetWatchListStatusSeriesTv = MockGetWatchListStatusSeriesTv();
    mockSaveWatchlistSeriesTv = MockSaveWatchlistSeriesTv();
    mockRemoveWatchlistSeriesTv = MockRemoveWatchlistSeriesTv();
    provider = SeriesTvDetailNotifier(
      getDetailSeriesTv: mockGetDetailSeriesTv,
      getRecommendationsSeriesTv: mockGetRecommendationsSeriesTv,
      getWatchlistSeriesTv: mockGetWatchListStatusSeriesTv,
      saveWatchlistSeriesTv: mockSaveWatchlistSeriesTv,
      removeWatchlistSeriesTv: mockRemoveWatchlistSeriesTv,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tId = 1;

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

  void _arrangeUsecase() {
    when(mockGetDetailSeriesTv.execute(tId))
        .thenAnswer((_) async => Right(testSeriesTvDetail));
    when(mockGetRecommendationsSeriesTv.execute(tId))
        .thenAnswer((_) async => Right(tSeriesList));
  }

  group('Get Tv Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetDetailSeriesTv.execute(tId));
      verify(mockGetRecommendationsSeriesTv.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.detailState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.detailState, RequestState.Loaded);
      expect(provider.detail, testSeriesTvDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation movies when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchTvSeriesDetail(tId);
          // assert
          expect(provider.detailState, RequestState.Loaded);
          expect(provider.seriesRecommendations, tSeriesList);
        });
  });

  group('Get Tv Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetRecommendationsSeriesTv.execute(tId));
      expect(provider.seriesRecommendations, tSeriesList);
    });

    test('should update recommendation state when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchTvSeriesDetail(tId);
          // assert
          expect(provider.recommendationState, RequestState.Loaded);
          expect(provider.seriesRecommendations, tSeriesList);
        });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetDetailSeriesTv.execute(tId))
          .thenAnswer((_) async => Right(testSeriesTvDetail));
      when(mockGetRecommendationsSeriesTv.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchListStatusSeriesTv.execute(1))
          .thenAnswer((_) async => true);
      // act
      await provider.loadSeriesTvWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistSeriesTv.execute(testSeriesTvDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListStatusSeriesTv.execute(testSeriesTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addSeriesTvWatchlist(testSeriesTvDetail);
      // assert
      verify(mockSaveWatchlistSeriesTv.execute(testSeriesTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistSeriesTv.execute(testSeriesTvDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchListStatusSeriesTv.execute(testSeriesTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testSeriesTvDetail);
      // assert
      verify(mockRemoveWatchlistSeriesTv.execute(testSeriesTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistSeriesTv.execute(testSeriesTvDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchListStatusSeriesTv.execute(testSeriesTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addSeriesTvWatchlist(testSeriesTvDetail);
      // assert
      verify(mockGetWatchListStatusSeriesTv.execute(testSeriesTvDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistSeriesTv.execute(testSeriesTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListStatusSeriesTv.execute(testSeriesTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addSeriesTvWatchlist(testSeriesTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetDetailSeriesTv.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetRecommendationsSeriesTv.execute(tId))
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.detailState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}