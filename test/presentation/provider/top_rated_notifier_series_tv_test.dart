import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series_tv.dart';
import 'package:ditonton/presentation/provider/top_rated_notifier_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'top_rated_notifier_series_tv_test.mocks.dart';

@GenerateMocks([GetTopRatedSeriesTv])
void main() {
  late MockGetTopRatedSeriesTv mockGetTopRatedSeriesTv;
  late TopRatedNotifierSeriesTv notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedSeriesTv = MockGetTopRatedSeriesTv();
    notifier =
        TopRatedNotifierSeriesTv (getTopRatedSeriesTv: mockGetTopRatedSeriesTv)
          ..addListener(() {
            listenerCallCount++;
          });
  });

  final tATVSeries = SeriesTv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: 'firstAirDate',
    name: 'name',
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    originCountry: ['originCountry'],
  );

  final tTVSeriesList = <SeriesTv>[tATVSeries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedSeriesTv.execute())
        .thenAnswer((_) async => Right(tTVSeriesList));
    // act
    notifier.fetchTopRatedTvSeries();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change Series Tv data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTopRatedSeriesTv.execute())
        .thenAnswer((_) async => Right(tTVSeriesList));
    // act
    await notifier.fetchTopRatedTvSeries();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.movies, tTVSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedSeriesTv.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTvSeries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
