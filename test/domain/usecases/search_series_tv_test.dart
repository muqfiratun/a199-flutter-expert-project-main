import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/search_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchSeriesTv usecase;
  late MockRepositorySeriesTv mockRepositorySeriesTv;

  setUp(() {
    mockRepositorySeriesTv = MockRepositorySeriesTv();
    usecase = SearchSeriesTv(mockRepositorySeriesTv);
  });

  final tSeries = <SeriesTv>[];
  final tQuery = 'Halo';

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockRepositorySeriesTv.searchSeriesTv(tQuery))
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tSeries));
  });
}