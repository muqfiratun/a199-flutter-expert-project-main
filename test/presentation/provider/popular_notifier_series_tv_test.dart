import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_series_tv.dart';
import 'package:ditonton/presentation/provider/popular_notifier_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'popular_notifier_series_tv_test.mocks.dart';

@GenerateMocks([GetTvPopular])
void main() {
  late MockGetTvPopular mockGetTvPopular;
  late PopularTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvPopular = MockGetTvPopular();
    notifier = PopularTvNotifier(mockGetTvPopular)
      ..addListener(() {
        listenerCallCount++;
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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTvPopular.execute())
        .thenAnswer((_) async => Right(tSeriesList));
    // act
    notifier.fetchPopularTv();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully',
          () async {
        // arrange
        when(mockGetTvPopular.execute())
            .thenAnswer((_) async => Right(tSeriesList));
        // act
        await notifier.fetchPopularTv();
        // assert
        expect(notifier.state, RequestState.Loaded);
        expect(notifier.series, tSeriesList);
        expect(listenerCallCount, 2);
      });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvPopular.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTv();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}