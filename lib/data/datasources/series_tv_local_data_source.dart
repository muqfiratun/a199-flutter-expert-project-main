import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/table_series_tv.dart';

abstract class SeriesTvLocalSource {
  Future<String> insertWatchlistSeriesTv(TableSeriesTv series);
  Future<String> removeWatchlistSeriesTv(TableSeriesTv series);
  Future<TableSeriesTv?> getSeriesTvById(int id);
  Future<List<TableSeriesTv>> getWatchlistSeriesTv();
}

class SeriesTvLocalSourceImpl implements  SeriesTvLocalSource {
  final DatabaseHelper databaseHelper;

  SeriesTvLocalSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistSeriesTv(TableSeriesTv series) async {
    try {
      await databaseHelper.insertWatchlistSeriesTv(series);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistSeriesTv(TableSeriesTv series) async {
    try {
      await databaseHelper.removeWatchlistSeriesTv(series);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TableSeriesTv?> getSeriesTvById(int id) async {
    final result = await databaseHelper.getSeriesTvById(id);
    if (result != null) {
      return TableSeriesTv.fromMap(result);
    } else{
      return null;
    }
  }

  @override
  Future<List<TableSeriesTv>> getWatchlistSeriesTv() async{
    final result = await databaseHelper.getWatchlistSeriesTv();
    return result.map((data) => TableSeriesTv.fromMap(data)).toList();
  }
}
