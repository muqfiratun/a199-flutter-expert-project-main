import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListSeriesTv usecase;
  late MockRepositorySeriesTv mockRepositorySeriesTv;

  setUp(() {
    mockRepositorySeriesTv = MockRepositorySeriesTv();
    usecase = GetWatchListSeriesTv(mockRepositorySeriesTv);
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockRepositorySeriesTv.getWatchlistSeriesTv())
        .thenAnswer((_) async => Right(testSeriesTvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testSeriesTvList));
  });
}