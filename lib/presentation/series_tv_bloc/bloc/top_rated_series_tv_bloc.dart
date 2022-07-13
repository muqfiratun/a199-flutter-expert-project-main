import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series_tv.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_series_tv_event.dart';
part 'top_rated_series_tv_state.dart';

class TopRatedSeriesTvBloc extends Bloc<TopRatedSeriesTvEvent, TopRatedSeriesTvState> {
  final GetTopRatedSeriesTv _getTopRatedSeriesTv;

  TopRatedSeriesTvBloc(this._getTopRatedSeriesTv) : super(TopRatedSeriesTvEmpty()) {
    on<OnTopRatedSeriesTvShow>((event, emit) async {
      emit(TopRatedSeriesTvLoading());
      final result = await _getTopRatedSeriesTv.execute();
      result.fold(
            (failure) {
          emit(TopRatedSeriesTvError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(TopRatedSeriesTvEmpty());
          } else {
            emit(TopRatedSeriesTvHasData(data));
          }
        },
      );
    });
  }
}
