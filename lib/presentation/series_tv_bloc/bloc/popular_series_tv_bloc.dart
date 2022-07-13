import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_series_tv.dart';
import 'package:equatable/equatable.dart';

part 'popular_series_tv_event.dart';
part 'popular_series_tv_state.dart';

class PopularSeriesTvBloc extends Bloc<PopularSeriesTvEvent, PopularSeriesTvState> {
  final GetTvPopular _getPopularSeriesTv;

  PopularSeriesTvBloc(this._getPopularSeriesTv) : super(PopularSeriesTvEmpty()) {
    on<OnPopularSeriesTvShow>((event, emit) async {
      emit(PopularSeriesTvLoading());
      final result = await _getPopularSeriesTv.execute();

      result.fold(
            (failure) {
          emit(PopularSeriesTvError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(PopularSeriesTvEmpty());
          } else {
            emit(PopularSeriesTvHasData(data));
          }
        },
      );
    });
  }
}
