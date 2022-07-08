import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_recommendations_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetRecommendationsSeriesTv usecase;
  late MockRepositorySeriesTv mockSeriesTvRepo;

  setUp(() {
    mockSeriesTvRepo = MockRepositorySeriesTv();
    usecase = GetRecommendationsSeriesTv(mockSeriesTvRepo);
  });

  final tId = 1;
  final tSeries = <SeriesTv>[];

  test('should get list of tv series recommendations from the repository',
          () async {
        // arrange
        when(mockSeriesTvRepo.getRecommendationsSeriesTv(tId))
            .thenAnswer((_) async => Right(tSeries));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(tSeries));
      });
}