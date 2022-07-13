import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistSeriesTv usecase;
  late MockSeriesTvRepository mockRepositorySeriesTv;

  setUp(() {
    mockRepositorySeriesTv = MockSeriesTvRepository();
    usecase = SaveWatchlistSeriesTv(mockRepositorySeriesTv);
  });

  test('should save tv series to the repository', () async {
    // arrange
    when(mockRepositorySeriesTv.saveWatchlistSeriesTv(testSeriesTvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testSeriesTvDetail);
    // assert
    verify(mockRepositorySeriesTv.saveWatchlistSeriesTv(testSeriesTvDetail));
    expect(result, Right('Added to Watchlist'));
  });
}