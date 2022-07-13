import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/search_series_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_series_tv_event.dart';
part 'search_series_tv_state.dart';

class SearchSeriesTvBloc extends Bloc<SearchSeriesTvEvent, SearchSeriesTvState> {
  final SearchSeriesTv _searchSeriesTv;

  SearchSeriesTvBloc(this._searchSeriesTv) : super(SearchSeriesTvEmpty()) {
    EventTransformer<T> debounce<T>(Duration duration) {
      return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
    }

    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchSeriesTvLoading());
      final result = await _searchSeriesTv.execute(query);

      result.fold(
            (failure) {
          emit(SearchSeriesTvError(failure.message));
        },
            (data) {
          emit(SearchSeriesTvHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}