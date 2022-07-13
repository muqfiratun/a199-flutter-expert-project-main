import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingSeriesTv usecase;
  late MockSeriesTvRepository mockSeriesTvRepository;

  setUp(() {
    mockSeriesTvRepository = MockSeriesTvRepository();
    usecase = GetNowPlayingSeriesTv(mockSeriesTvRepository);
  });

  final tSeries = <SeriesTv>[];

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockSeriesTvRepository.getNowPlayingSeriesTv())
        .thenAnswer((_) async => Right(tSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tSeries));
  });
}