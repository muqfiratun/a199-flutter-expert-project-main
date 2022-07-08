import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistSeriesTv usecase;
  late MockRepositorySeriesTv mockRepositorySeriesTv;

  setUp(() {
    mockRepositorySeriesTv = MockRepositorySeriesTv();
    usecase = RemoveWatchlistSeriesTv(mockRepositorySeriesTv);
  });

  test('should remove watchlist series tv from repository', () async {
    // arrange
    when(mockRepositorySeriesTv.removeWatchlistSeriesTv(testSeriesTvDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testSeriesTvDetail);
    // assert
    verify(mockRepositorySeriesTv.removeWatchlistSeriesTv(testSeriesTvDetail));
    expect(result, Right('Removed from watchlist'));
  });
}