import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvPopular usecase;
  late MockSeriesTvRepository mockRpositorySeriesTv;

  setUp(() {
    mockRpositorySeriesTv = MockSeriesTvRepository();
    usecase = GetTvPopular(mockRpositorySeriesTv);
  });

  final tSeries = <SeriesTv>[];

  group('GetPopularMovies Tests', () {
    group('execute', () {
      test(
          'should get list of tv series from the repository when execute function is called',
              () async {
            // arrange
            when(mockRpositorySeriesTv.getTvPopular())
                .thenAnswer((_) async => Right(tSeries));
            // act
            final result = await usecase.execute();
            // assert
            expect(result, Right(tSeries));
          });
    });
  });
}