import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedSeriesTv usecase;
  late MockRepositorySeriesTv mockRepositorySeriesTv;

  setUp(() {
    mockRepositorySeriesTv = MockRepositorySeriesTv();
    usecase = GetTopRatedSeriesTv(mockRepositorySeriesTv);
  });

  final tSeries = <SeriesTv>[];

  test('should get list of tv series from repository', () async {
    // arrange
    when(mockRepositorySeriesTv.getTopRatedSeriesTv())
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeries));
  });
}