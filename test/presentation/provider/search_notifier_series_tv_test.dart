import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/search_series_tv.dart';
import 'package:ditonton/presentation/provider/search_notifier_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'search_notifier_series_tv_test.mocks.dart';

@GenerateMocks([SearchSeriesTv])
void main() {
  late SearchNotifierSeriesTv provider;
  late MockSearchSeriesTv mockSearchSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchSeries = MockSearchSeriesTv();
    provider = SearchNotifierSeriesTv(searchSeriesTv: mockSearchSeries)
      ..addListener(() {
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
  final tQuery = 'spiderman';

  group('search tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchTvSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
            () async {
          // arrange
          when(mockSearchSeries.execute(tQuery))
              .thenAnswer((_) async => Right(tSeriesList));
          // act
          await provider.fetchTvSeriesSearch(tQuery);
          // assert
          expect(provider.state, RequestState.Loaded);
          expect(provider.searchResult, tSeriesList);
          expect(listenerCallCount, 2);
        });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}