import 'package:ditonton/domain/usecases/get_watchlist_status_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusSeriesTv usecase;
  late MockRepositorySeriesTv mockRepositorySeriesTv;

  setUp(() {
    mockRepositorySeriesTv = MockRepositorySeriesTv();
    usecase = GetWatchListStatusSeriesTv(mockRepositorySeriesTv);
  });

  test('should get tv series watchlist status from repository', () async {
    // arrange
    when(mockRepositorySeriesTv.seriesTvIsAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}