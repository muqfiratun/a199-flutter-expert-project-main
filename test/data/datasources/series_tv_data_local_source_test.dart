import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/series_tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SeriesTvLocalSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource =
        SeriesTvLocalSourceImpl (databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.insertWatchlistSeriesTv(testSeriesTvTable))
              .thenAnswer((_) async => 1);
          // act
          final result =
          await dataSource.insertWatchlistSeriesTv(testSeriesTvTable);
          // assert
          expect(result, 'Added to Watchlist');
        });

    test('should throw DatabaseException when insert to database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.insertWatchlistSeriesTv(testSeriesTvTable))
              .thenThrow(Exception());
          // act
          final call = dataSource.insertWatchlistSeriesTv(testSeriesTvTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
            () async {
          // arrange
          when(mockDatabaseHelper.removeWatchlistSeriesTv(testSeriesTvTable))
              .thenAnswer((_) async => 1);
          // act
          final result =
          await dataSource.removeWatchlistSeriesTv(testSeriesTvTable);
          // assert
          expect(result, 'Removed from Watchlist');
        });

    test('should throw DatabaseException when remove from database is failed',
            () async {
          // arrange
          when(mockDatabaseHelper.removeWatchlistSeriesTv(testSeriesTvTable))
              .thenThrow(Exception());
          // act
          final call = dataSource.removeWatchlistSeriesTv(testSeriesTvTable);
          // assert
          expect(() => call, throwsA(isA<DatabaseException>()));
        });
  });

  group('Get Tv Series Detail By Id', () {
    final tId = 1;

    test('should return Tv Series Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getSeriesTvById(tId))
          .thenAnswer((_) async => testSeriesTvMap);
      // act
      final result = await dataSource.getSeriesTvById(tId);
      // assert
      expect(result, testSeriesTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getSeriesTvById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getSeriesTvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistSeriesTv())
          .thenAnswer((_) async => [testSeriesTvMap]);
      // act
      final result = await dataSource.getWatchlistSeriesTv();
      // assert
      expect(result, [testSeriesTvTable]);
    });
  });
}