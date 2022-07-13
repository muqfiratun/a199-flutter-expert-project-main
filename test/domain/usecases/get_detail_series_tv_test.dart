import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_detail_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetDetailSeriesTv usecase;
  late MockSeriesTvRepository mockSeriesTvRepository;

  setUp(() {
    mockSeriesTvRepository = MockSeriesTvRepository();
    usecase = GetDetailSeriesTv(mockSeriesTvRepository);
  });

  final tId = 1;

  test('should get series tv detail from the repository', () async {
    // arrange
    when(mockSeriesTvRepository.getDetailSeriesTv(tId))
        .thenAnswer((_) async => Right(testSeriesTvDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testSeriesTvDetail));
  });
}