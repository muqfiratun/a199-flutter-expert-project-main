import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series_tv.dart';
import 'package:ditonton/presentation/provider/watchlist_notifier_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import 'watchlist_notifier_series_tv_test.mocks.dart';

@GenerateMocks([GetWatchListSeriesTv])
void main() {
  late WatchlistSeriesTvNotifier provider;
  late MockGetWatchListSeriesTv mockGetWatchListSeriesTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchListSeriesTv = MockGetWatchListSeriesTv();
    provider = WatchlistSeriesTvNotifier(
      getWatchListSeriesTv: mockGetWatchListSeriesTv,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  test('should change tv series data when data is gotten successfully',
          () async {
        // arrange
        when(mockGetWatchListSeriesTv.execute())
            .thenAnswer((_) async => Right([testWatchlistSeriesTv]));
        // act
        await provider.fetchWatchlistTvSeries();
        // assert
        expect(provider.watchlistState, RequestState.Loaded);
        expect(provider.watchlistTvSeries, [testWatchlistSeriesTv]);
        expect(listenerCallCount, 2);
      });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchListSeriesTv.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistTvSeries();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}